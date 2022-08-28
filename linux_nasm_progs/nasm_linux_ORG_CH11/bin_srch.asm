;Binary search of a sorted integer array   BIN_SRCH.ASM
;
;        Objective: To implement binary search of a sorted
;                   integer array.
;            Input: Requests numbers to fill array and a 
;                   number to be searched for from user.
;           Output: Displays the position of the number in
;                   the array if found; otherwise, not found
;                   message.
%include "io.mac"

.DATA
MAX_SIZE       EQU 100
input_prompt   db  "Please enter input array (in sorted order): "
               db  "(negative number terminates input)",0
query_number   db  "Enter the number to be searched: ",0
out_msg        db  "The number is at position ",0
not_found_msg  db  "Number not in the array!",0
query_msg      db  "Do you want to quit (Y/N): ",0

.UDATA
array          resw  MAX_SIZE

.CODE
        .STARTUP
        PutStr  input_prompt ; request input array
        nwln
        sub     ESI,ESI      ; set index to zero
        mov     CX,MAX_SIZE
array_loop:
        GetInt  AX           ; read an array number

        cmp     AX,0            ; negative number?
        jl      exit_loop       ; if so, stop reading numbers
        mov     [array+ESI*2],AX ; otherwise, copy into array
        inc     ESI           ; increment array index
        loop    array_loop   ; iterates a maximum of MAX_SIZE
exit_loop:
read_input:
        PutStr  query_number ; request number to be searched for
        GetInt  AX           ; read the number
        push    AX           ; push number, size & array pointer
        push    SI
        push    array
        call    binary_search
        ; binary_search returns in AX the position of the number 
        ; in the array; if not found, it returns 0.
        cmp     AX,0         ; number found?
        je      not_found    ; if not, display number not found
        PutStr  out_msg      ; else, display number position
        PutInt  AX
        jmp     user_query
not_found:
        PutStr  not_found_msg
user_query:
        nwln
        PutStr  query_msg    ; query user whether to terminate
        GetCh   AL           ; read response
        cmp     AL,'Y'       ; if response is not 'Y'
        jne     read_input   ; repeat the loop
done:                        ; otherwise, terminate program
        .EXIT

;-----------------------------------------------------------
; This procedure receives a pointer to an array of integers,
; the array size, and a number to be searched via the stack.
; It returns in AX the position of the number in the array
; if found; otherwise, returns 0.
; All registers, except AX, are preserved.
;-----------------------------------------------------------
.CODE
binary_search:
       enter   0,0
       push    EBX
       push    ESI
       push    CX
       push    DX
       mov     EBX,[EBP+8]   ; copy array pointer
       mov     CX,[EBP+12]   ; copy array size
       mov     DX,[EBP+14]   ; copy number to be searched
       xor     AX,AX         ; lower = 0
       dec     CX            ; upper = size-1
while_loop:
       cmp     AX,CX         ;lower > upper?
       ja      end_while
       sub     ESI,ESI       
       mov     SI,AX         ; middle = (lower + upper)/2
       add     SI,CX
       shr     SI,1
       cmp     DX,[EBX+ESI*2]    ; number = array[middle]?
       je      search_done
       jg      upper_half
lower_half:
       dec     SI            ; middle = middle-1
       mov     CX,SI         ; upper = middle-1
       jmp     while_loop
upper_half:
       inc     SI            ; middle = middle+1
       mov     AX,SI         ; lower = middle+1
       jmp     while_loop
end_while:
       sub     AX,AX         ; number not found (clear AX)
       jmp     skip1
search_done:
       inc     SI            ; position = index+1
       mov     AX,SI         ; return position
skip1:
       pop     DX            ; restore registers
       pop     CX
       pop     ESI
       pop     EBX
       leave
       ret     8
