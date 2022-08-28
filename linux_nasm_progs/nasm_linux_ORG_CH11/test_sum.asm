;Sum of a column in a 2-dimensional array  TEST_SUM.ASM
;
;        Objective: To demonstrate array index manipulation
;                   in a two-dimensional array of integers.
;            Input: None.
;           Output: Displays the sum.
%include "io.mac"

.DATA
NO_ROWS        EQU  5
NO_COLUMNS     EQU  3
NO_ROW_BYTES   EQU  NO_COLUMNS * 2  ; number of bytes per row
class_marks    dw   90,89,99
               dw   79,66,70
               dw   70,60,77
               dw   60,55,68
               dw   51,59,57

sum_msg        db   "The sum of the last test marks is: ",0

.CODE
        .STARTUP
        mov     CX,NO_ROWS   ; loop iteration count
        sub     AX,AX        ; sum = 0
        ; ESI = index of class_marks[0,2]
        sub     EBX,EBX
        mov     ESI,NO_COLUMNS-1  
sum_loop:
        add     AX,[class_marks+EBX+ESI*2]
        add     EBX,NO_ROW_BYTES
        loop    sum_loop
        
        PutStr  sum_msg
        PutInt  AX
        nwln
done:        
        .EXIT
