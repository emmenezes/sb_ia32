;8-bit multiplication using shifts   SHL_MLT.ASM
;
;        Objective: To multiply two 8-bit unsigned numbers
;                   using SHL rather than MUL instruction.
;            Input: Requests two unsigned numbers from user.
;           Output: Prints the multiplication result.
%include "io.mac"

.DATA
input_prompt   db  "Please input two short numbers: ",0
out_msg1       db  "The multiplication result is: ",0
query_msg      db  "Do you want to quit (Y/N): ",0

.CODE
        .STARTUP
read_input:
        PutStr  input_prompt ; request two numbers
        GetInt  AX           ; read the first number
        GetInt  BX           ; read the second number
        call    mult8        ; mult8 uses SHL instruction
        PutStr  out_msg1
        PutInt  AX           ; mult8 leaves result in AX
        nwln
        PutStr  query_msg    ; query user whether to terminate
        GetCh   AL           ; read response
        cmp     AL,'Y'       ; if response is not 'Y'
        jne     read_input   ; repeat the loop
done:                        ; otherwise, terminate program
        .EXIT

;-----------------------------------------------------------
; mult8 multiplies two 8-bit unsigned numbers passed on to
; it in registers AL and BL. The 16-bit result is returned 
; in AX. This procedure uses only SHL instruction to do the
; multiplication. All registers, except AX, are preserved.
;-----------------------------------------------------------
mult8:
       push    CX            ; save registers
       push    DX
       push    SI
       xor     DX,DX         ; DX = 0 (keeps mult. result)
       mov     CX,7          ; CX = # of shifts required
       mov     SI,AX         ; save original number in SI
repeat1:       ; multiply loop - iterates 7 times
       rol     BL,1          ; test bits of number2 from left
       jnc     skip1         ; if 0, do nothing
       mov     AX,SI         ; else, AX = number1*bit weight
       shl     AX,CL
       add     DX,AX         ; update running total in DX
skip1:
       loop    repeat1    
       rol     BL,1          ; test the rightmost bit of AL
       jnc     skip2         ; if 0, do nothing
       add     DX,SI         ; else, add number1
skip2:
       mov     AX,DX         ; move final result into AX
       pop     SI            ; restore registers
       pop     DX
       pop     CX
       ret
