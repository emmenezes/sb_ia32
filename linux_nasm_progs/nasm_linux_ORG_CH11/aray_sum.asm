;Sum of a long integer array       ARAY_SUM.ASM
;
;        Objective: To find sum of all elements of an array.
;            Input: None.
;           Output: Displays the sum.
%include "io.mac"

.DATA
test_marks     DD  90,50,70,94,81,40,67,55,60,73
NO_STUDENTS    EQU ($-test_marks)/4     ; number of students
sum_msg        DB  'The sum of test marks is: ',0

.CODE
        .STARTUP
        mov     CX,NO_STUDENTS   ; loop iteration count
        sub     EAX,EAX          ; sum := 0
        sub     ESI,ESI          ; array index := 0
add_loop:
        mov     EBX,[test_marks+ESI*4]
        PutLInt EBX
        nwln
        add     EAX,[test_marks+ESI*4]
        inc     ESI
        loop    add_loop
        
        PutStr  sum_msg
        PutLInt EAX
        nwln
        .EXIT        
