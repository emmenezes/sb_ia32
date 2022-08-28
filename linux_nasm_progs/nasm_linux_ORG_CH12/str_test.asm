;Program to test string procedures    STR_TEST.ASM
;        Objective: To test all string processing procedures
;                   in STRING.ASM and to illustrate how
;                   indirect procedure call can be used.
;           Inputs: As per queries.
;          Outputs: Displayed on the screen.
%include "io.mac"
CR              EQU 0DH
LF              EQU 0AH
STR_MAX         EQU 128

.DATA
proc_ptr_table  dd  str_len_fun, str_cpy_fun, str_cat_fun
		dd  str_cmp_fun, str_chr_fun, str_cnv_fun
	        dd  str_mov_fun
MAX_FUNCTIONS   EQU ($ - proc_ptr_table)/4

choice_prompt   db  "You can test several functions.",CR,LF
                db  "    To test       enter",CR,LF
                db  "String length       1",CR,LF
                db  "String copy         2",CR,LF
                db  "String concatenate  3",CR,LF
                db  "String compare      4",CR,LF
                db  "Locate character    5",CR,LF
                db  "Convert string      6",CR,LF
                db  "Move string         7",CR,LF
                db  "Invalid response terminates program.",CR,LF
                db  "Please enter your choice: ",0

invalid_choice  db  "Invalid choice - program terminates.",0
string0_msg     db  "Please enter a string: ",0
string1_msg     db  "Please enter the first string: ",0
string2_msg     db  "Please enter the second string: ",0
char_msg        db  "Please enter a search character: ",0
number_msg      db  "Please enter # places to move: ",0

str_len_msg     db  "String length = ",0
str_cpy_msg     db  "The copied string is: ",0
str_cat_msg     db  "First string now contains: ",0

str_match_msg   db  "Both strings match.",0
str1_below_msg  db  "First string is less than second string.",0
str1_above_msg  db  "First string is greater than second string.",0

str_chr_msg     db  "The character is located at: ",0
str_chr_err_msg db  "No character match!",0
str_cnv_msg     db  "The converted string is: ",0
str_mov_msg     db  "The updated string is: ",0


no_string_msg   db  "Error: Not a string!",0
str_len_hdr_msg db  "String length function selected.",0
str_cpy_hdr_msg db  "String copy function selected.",0
str_cat_hdr_msg db  "String concatenate function selected.",0
str_cmp_hdr_msg db  "String compare function selected.",0
str_chr_hdr_msg db  "Locate character function selected.",0
str_cnv_hdr_msg db  "Convert string function selected.",0
str_mov_hdr_msg db  "Move string function selected.",0

.UDATA
string1         resb  STR_MAX
string2         resb  STR_MAX


.CODE

EXTERN   str_len, str_cpy, str_cat, str_cmp, str_chr
EXTERN   str_cnv, str_mov
	
        .STARTUP		
	 mov     AX,DS
	 mov     ES,AX
query_choice1:
        xor     EBX,EBX
        PutStr  choice_prompt    ; display menu
        GetCh   BL               ; read response
         sub     BL,'1'
        cmp     BL,0
        jb      invalid_response
        cmp     BL,MAX_FUNCTIONS
        jb      response_ok
invalid_response:
        PutStr  invalid_choice
        jmp     SHORT done
response_ok:
        shl     BL,2                 ; multiply BL by 4
        call    [proc_ptr_table+EBX] ; indirect call
        jmp     query_choice1
done:
        .EXIT

;----------------------------------------------------------------
str_len_fun:
        PutStr  str_len_hdr_msg
        nwln
        PutStr  string0_msg
        GetStr  string1,STR_MAX
        push    DS
        push    string1
        call    str_len		
        call    error1	
        PutStr  str_len_msg
        PutInt  AX
        nwln
        ret
;================================================================

;----------------------------------------------------------------	
str_cpy_fun:
        PutStr  str_cpy_hdr_msg
        nwln
        PutStr  string0_msg
        GetStr  string2,STR_MAX
        push    DS
        push    string2
        push    ES
        push    string1
        call    str_cpy
        call    error1
        PutStr  str_cpy_msg
        PutStr  string1
        nwln
        ret
;================================================================

;----------------------------------------------------------------
str_cat_fun:
        PutStr  str_cat_hdr_msg
        nwln
        PutStr  string1_msg
        GetStr  string1,STR_MAX
        PutStr  string2_msg
        GetStr  string2,STR_MAX
        push    DS
        push    string2
        push    ES
        push    string1
        call    str_cat
        call    error1
        PutStr  str_cat_msg
        PutStr  string1
        nwln
        ret
;================================================================

;----------------------------------------------------------------
str_cmp_fun:
        PutStr  str_cmp_hdr_msg
        nwln
        PutStr  string1_msg
        GetStr  string1,STR_MAX
        PutStr  string2_msg
        GetStr  string2,STR_MAX
        push    DS
        push    string2
        push    ES
        push    string1
        call    str_cmp
        call    error1
        cmp     AX,0
        je      str_match
        jg      str1_above
str1_below:
        PutStr  str1_below_msg
        jmp     SHORT sm_skip
str_match:
        PutStr  str_match_msg
        jmp     SHORT sm_skip
str1_above:
        PutStr  str1_above_msg
sm_skip:
        nwln
        ret
;================================================================

;----------------------------------------------------------------
str_chr_fun:
        PutStr  str_chr_hdr_msg
        nwln
        PutStr  string0_msg
        GetStr  string1,STR_MAX
        PutStr  char_msg
        GetCh   AL
        xor     AH,AH
        push    AX
        push    DS
        push    string1
        call    str_chr
        call    error1
        cmp     AX,0
        jne     skip_err
        PutStr  str_chr_err_msg
        jmp     SHORT finished
skip_err:
        PutStr  str_chr_msg
        sub     EAX,string1-1
        PutInt  AX
finished:
        nwln
        ret
;================================================================

;----------------------------------------------------------------
str_cnv_fun:
        PutStr  str_cnv_hdr_msg
        nwln
        PutStr  string0_msg
        GetStr  string2,STR_MAX
        push    DS
        push    string2
        push    ES
        push    string1
        call    str_cnv
        call    error1
        PutStr  str_cnv_msg
        PutStr  string1
        nwln
        ret
;================================================================

;----------------------------------------------------------------
str_mov_fun:
        PutStr  str_mov_hdr_msg
        nwln
        PutStr  string0_msg
        GetStr  string2,STR_MAX
        PutStr  number_msg
	xor     EDX,EDX
        GetLInt EDX
        push    EDX
        push    DS
        mov     EAX,string2
        cmp     DX,0
        jge     skip1
        sub     EAX,EDX
skip1:
        push    EAX
        call    str_mov
        call    error1
        PutStr  str_mov_msg
        PutStr  string2
        nwln
        ret
;================================================================

;----------------------------------------------------------------	
error1:
        jnc     no_error
        PutStr  no_string_msg
        nwln
	.EXIT
no_error:
        ret
;================================================================