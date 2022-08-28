;Procedures for string processing    STRING.ASM
;	Objective: Use string instructions to write
;		   some example string functions.
;	   Inputs: Pointers to source and/or dest. strings
;		   Each pointer should have segment & offset
;	   Output: According to the function. Carry flag is 
;		   used to indicate "no string error" if one
;		   of the strings is not a string with length
;                   less than STR_MAX.
%include "io.mac"
STR_MAX   EQU   128   ; maximum string length
%define STRING1   [EBP+8]
%define STRING2   [EBP+16]

.CODE
global  str_len, str_cpy, str_cat, str_cmp, str_chr
global  str_cnv, str_mov

;-----------------------------------------------------------
;String length procedure. Receives a string pointer 
;(seg:offset) via the stack. If not a string, CF is set;
;otherwise, string length is returned in AX with CF = 0.
;Preserves all registers.
;-----------------------------------------------------------
str_len:
	push    EBP
	mov     EBP,ESP
	push    ECX
	push    EDI
	push    ES

	les     EDI,STRING1 ; copy string pointer to ES:EDI
	mov     ECX,STR_MAX  ; needed to terminate loop if BX
			    ;  is not pointing to a string
	cld                 ; forward search
	mov     AL,0        ; NULL character
	repne   scasb
	jcxz    sl_no_string  ; if CX = 0, not a string
	dec     EDI           ; back up to point to NULL
	mov     EAX,EDI
	sub     EAX,STRING1  ; string length in AX
	clc                  ; no error
	jmp     SHORT sl_done
sl_no_string:
	stc                  ; carry set => no string
sl_done:
	pop     ES
	pop     EDI
	pop     ECX
	pop     EBP
	ret     8            ; clear stack and return

;-----------------------------------------------------------
;String copy procedure. Receives two string pointers
;(seg:offset) via the stack - string1 and string2. 
;If string2 is not a string, CF is set;
;otherwise, string2 is copied to string1 and the 
;offeset of string1 is returned in AX with CF = 0.
;Preserves all registers.
;-----------------------------------------------------------
str_cpy:
	push    EBP
	mov     EBP,ESP
	push    CX
	push    EDI
	push    ESI
	push    DS
	push    ES
	; find string length first
	lds     ESI,STRING2  ; src string pointer
	push    DS
	push    ESI        
	call    str_len
	jc      sc_no_string
	
	mov     CX,AX       ; src string length in CX
	inc     CX          ; add 1 to include NULL
	les     EDI,STRING1 ; dest string pointer
	cld                 ; forward search
	rep     movsb
	mov     EAX,STRING1 ; return dest string pointer
	clc                 ; no error
	jmp     SHORT sc_done
sc_no_string:
	stc                 ; carry set => no string
sc_done:
	pop     ES
	pop     DS
	pop     ESI
	pop     EDI
	pop     CX
	pop     EBP
	ret     16          ; clear stack and return


;-----------------------------------------------------------
;String concatenate procedure. Receives two string pointers
;(seg:offset) via the stack - string1 and string2. 
;If string1 and/or string2 are not strings, CF is set;
;otherwise, string2 is concatenated to the end of string1 
;and the offset of string1 is returned in AX with CF = 0.
;Preserves all registers.
;-----------------------------------------------------------
str_cat:
	push    EBP
	mov     EBP,ESP
	push    CX
	push    EDI
	push    ESI
	push    DS
	push    ES
	; find string length first
	les     EDI,STRING1 ; dest string pointer
	mov     CX,STR_MAX  ; max string length
	cld                 ; forward search
	mov     AL,0        ; NULL character
	repne   scasb
	jcxz    st_no_string
	dec     EDI         ; back up to point to NULL
	lds     ESI,STRING2 ; src string pointer
	push    DS
	push    ESI
	call    str_len
	jc      st_no_string
	
	mov     CX,AX      ; src string length in CX
	inc     CX         ; add 1 to include NULL
	cld                ; forward search
	rep     movsb
	mov     AX,[EBP+4] ; return dest string pointer
	clc                ; no error
	jmp     SHORT st_done
st_no_string:
	stc                ; carry set => no string
st_done:
	pop     ES
	pop     DS
	pop     ESI
	pop     EDI
	pop     CX
	pop     EBP
	ret     16         ; clear stack and return

;-----------------------------------------------------------
;String compare procedure. Receives two string pointers
;(seg:offset) via the stack - string1 and string2. 
;If string2 is not a string, CF is set;
;otherwise, string1 and string2 are compared and returns a
;a value in AX with CF = 0 as shown below:
;    AX = negative value  if string1 < string2
;    AX = zero            if string1 = string2
;    AX = positive value  if string1 > string2
;Preserves all registers.
;-----------------------------------------------------------
str_cmp:
	push    EBP
	mov     EBP,ESP
	push    CX
	push    EDI
	push    ESI
	push    DS
	push    ES
	; find string length first
	les     EDI,STRING2  ; string2 pointer
	push    ES
	push    EDI
	call    str_len
	jc      sm_no_string
	
	mov     CX,AX      ; string1 length in CX
	inc     CX         ; add 1 to include NULL
	lds     ESI,STRING1 ; string1 pointer
	cld                ; forward search
	repe    cmpsb
	je      same
	ja      above
below:
	mov     AX,-1      ; AX = -1 => string1 < string2
	clc
	jmp     SHORT sm_done
same:
	xor     AX,AX      ; AX = 0 => string match
	clc
	jmp     SHORT sm_done
above:
	mov     AX,1       ; AX = 1 => string1 > string2
	clc
	jmp     SHORT sm_done
sm_no_string:
	stc                ; carry set => no string
sm_done:
	pop     ES
	pop     DS
	pop     ESI
	pop     EDI
	pop     CX
	pop     EBP
	ret     16         ; clear and return

;-----------------------------------------------------------
;String locate a character procedure. Receives a character
;and a string pointer (seg:offset) via the stack. 
;char should be passed as a 16-bit word.
;If string1 is not a string, CF is set;
;otherwise, locates the first occurrence of char in string1
;and returns a pointer to the located char in AX (if the 
;search is successful; otherwise AX = NULL) with CF = 0.
;Preserves all registers.
;-----------------------------------------------------------
str_chr:
	push    EBP
	mov     EBP,ESP
	push    CX
	push    EDI
	push    ES
	; find string length first
	les     EDI,STRING1  ; src string pointer
	push    ES
	push    EDI        
	call    str_len
	jc      sh_no_string
	
	mov     CX,AX       ; src string length in CX
	inc     CX
	mov     AX,[EBP+16] ; read char. into AL
	cld                 ; forward search
	repne   scasb
	dec     EDI         ; back up to match char.
	xor     AX,AX       ; assume no char match (AX=NULL)
	jcxz    sh_skip
	mov     AX,DI       ; return pointer to char.
sh_skip:
	clc                 ; no error
	jmp     SHORT sh_done
sh_no_string:
	stc                 ; carry set => no string
sh_done:
	pop     ES
	pop     EDI
	pop     CX
	pop     EBP
	ret     10          ; clear stack and return

;-----------------------------------------------------------
;String convert procedure. Receives two string pointers
;(seg:offset) via the stack - string1 and string2. 
;If string2 is not a string, CF is set;
;otherwise, string2 is copied to string1 and lowercase
;letters are converted to corresponding uppercase letters.
;string2 is not modified in any way. 
;It returns a pointer to string1 in AX with CF = 0.
;Preserves all registers.
;-----------------------------------------------------------
str_cnv:
	push    EBP
	mov     EBP,ESP
	push    CX
	push    EDI
	push    ESI
	push    DS
	push    ES
	; find string length first
	lds     ESI,STRING2 ; src string pointer
	push    DS
	push    ESI        
	call    str_len
	jc      sn_no_string
	
	mov     CX,AX       ; src string length in CX
	inc     CX          ; add 1 to include NULL
	les     EDI,STRING1 ; dest string pointer
	cld                 ; forward search
loop1:
	lodsb
	cmp     AL,'a'      ; lowercase letter?
	jb      sn_skip
	cmp     AL,'z'
	ja      sn_skip     ; if no, skip conversion
	sub     AL,20H      ; if yes, convert to uppercase
sn_skip:
	stosb
	loop    loop1
	rep     movsb
	mov     EAX,STRING1 ; return dest string pointer
	clc                 ; no error
	jmp     SHORT sn_done
sn_no_string:
	stc                 ; carry set => no string
sn_done:
	pop     ES
	pop     DS
	pop     ESI
	pop     EDI
	pop     CX
	pop     EBP
	ret     16         ; clear stack and return

;-----------------------------------------------------------
;String move procedure. Receives a signed integer
;and a string pointer (seg:offset) via the stack. 
;The integer indicates the number of positions to move
;the string:
;      -ve number => left move
;      +ve number => right move
;If string1 is not a string, CF is set;
;otherwise, string is moved left or right and returns
;a pointer to the modified string in AX with CF = 0.
;Preserves all registers.
;-----------------------------------------------------------
str_mov:
	push    EBP
	mov     EBP,ESP
	push    ECX
	push    EDI
	push    ESI
	push    DS
	push    ES
	; find string length first
	xor     ECX,ECX
	lds     ESI,STRING1  ; string pointer
	push    DS
	push    ESI        
	call    str_len
	jnc     sv_skip1
	jmp     sv_no_string
sv_skip1:
	mov     CX,AX       ; string length in CX
	inc     CX          ; add 1 to include NULL
	les     EDI,STRING1 
	mov     EAX,[EBP+16]; copy # of positions to move
	cmp     EAX,0       ; -ve number => left move
	jl      move_left   ; +ve number => right move
	je      finish      ; zero => no move
move_right:
	; prepare SI and DI for backward copy
	add     ESI,ECX     ; ESI points to the
	dec     ESI         ;  NULL character
	mov     EDI,ESI     ; EDI = ESI + # of positions to move
	add     EDI,EAX
	std                 ; backward copy
	rep     movsb
	; now erase the remainder of the old string
	;  by writing blanks
	mov     CX,[EBP+16]  ; # of positions moved
	; DI points to the first char of left-over string
	mov     AL,' '     ; blank char to fill
	; direction flag is set previously
	rep     stosb
	jmp     SHORT finish
move_left:
	add     EDI,EAX
	cld                 ; forward copy
	rep     movsb
finish:        
	mov     EAX,[EBP+16] ; add # of positions to move
	add     EAX,[EBP+8]  ; to string pointer (ret value)
	clc                  ; no error
	jmp     SHORT sv_done
sv_no_string:
	stc                 ; carry set => no string
sv_done:
	pop     ES
	pop     DS
	pop     ESI
	pop     EDI
	pop     ECX
	pop     EBP
	ret     12          ; clear stack and return
