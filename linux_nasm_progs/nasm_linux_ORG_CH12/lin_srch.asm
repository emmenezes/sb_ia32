;Linear search of integer array      LIN_SRCH.ASM
;
;        Objective: To implement linear search of an integer
;                   array; demonstrates the use of loopne.
;            Input: Requests numbers to fill array and a 
;                   number to be searched for from user.
;           Output: Displays the position of the number in
;                   the array if found; otherwise, not found
;                   message.
%include "io.mac"

.DATA
MAX_SIZE       EQU   100
input_prompt   db    "Please enter input array: "
               db    "(negative number terminates input)",0
query_number   db    "Enter the number to be searched: ",0
out_msg        db    "The number is at position ",0
not_found_msg  db    "Number not in the array!",0
query_msg      db    "Do you want to quit (Y/N): ",0

.UDATA
array          resw  MAX_SIZE

.CODE
        .STARTUP
        PutStr  input_prompt ; request input array
        mov     EBX,array
        mov     CX,MAX_SIZE
array_loop:
        GetInt  AX           ; read an array number
        cmp     AX,0         ; negative number?
        jl      exit_loop    ; if so, stop reading numbers
        mov     [EBX],AX      ; otherwise, copy into array
        inc     EBX           ; increment array address
        inc     EBX
        loop    array_loop   ; iterates a maximum of MAX_SIZE
exit_loop:
        mov     EDX,EBX        ; DX keeps the actual array size
        sub     EDX,array     ; DX = array size in bytes
        sar     EDX,1         ; divide by 2 to get array size
read_input:
        PutStr  query_number ; request number to be searched for
        GetInt  AX           ; read the number
        push    AX           ; push number, size & array pointer
        push    DX
        push    array
        call    linear_search
        ; linear_search returns in AX the position of the number 
        ; in the array; if not found, it returns 0.
        cmp     AX,0         ; number found?
        je      not_found    ; if not, display number not found
        PutStr  out_msg      ; else, display number position
        PutInt  AX
        jmp     SHORT user_query
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
; If found, it returns in AX the position of the number in
; the array; otherwise, returns 0.
; All registers, except AX, are preserved.
;-----------------------------------------------------------
linear_search:
       enter   0,0
       push    EBX           ; save registers
       push    CX
       mov     EBX,[EBP+8]   ; copy array pointer
       mov     CX,[EBP+12]   ; copy array size
       mov     AX,[EBP+14]   ; copy number to be searched
       sub     EBX,2         ; adjust index to enter loop
search_loop:
       add     EBX,2         ; update array index
       cmp     AX,[EBX]      ; compare the numbers
       loopne  search_loop
       mov     AX,0          ; set return value to zero
       jne     number_not_found  ; modify it if number found
       mov     AX,[EBP+12]   ; copy array size
       sub     AX,CX         ; compute array index of number
number_not_found:
       pop     CX            ; restore registers
       pop     EBX
       leave
       ret     8
