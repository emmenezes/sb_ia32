global _start 
section .data 

ROWS EQU 10 
COLUMNS EQU 10 

array1  db 90,89,99,91,92,95,77,38,69,10 
        db 79,66,70,60,55,68,70,60,77,10 
        db 70,60,77,90,89,99,91,92,95,10 
        db 60,55,68,79,66,70,60,55,68,10 
        db 51,59,57,02,92,95,77,38,69,10 
        db 79,66,70,60,55,68,70,60,77,10 
        db 70,60,77,90,89,99,91,92,95,10 
        db 60,55,68,79,66,70,60,55,68,10 
        db 51,59,57,02,92,95,77,38,69,10 
        db 79,66,70,60,55,68,70,60,77,10 
array2  db 1,2,3,4,5,6,7,8,9,10 
        db 1,2,3,4,5,6,7,8,9,10 
        db 1,2,3,4,5,6,7,8,9,10 
        db 1,2,3,4,5,6,7,8,9,10 
        db 1,2,3,4,5,6,7,8,9,10 
        db 1,2,3,4,5,6,7,8,9,10 
        db 1,2,3,4,5,6,7,8,9,10 
        db 1,2,3,4,5,6,7,8,9,10 
        db 1,2,3,4,5,6,7,8,9,10 
        db 1,2,3,4,5,6,7,8,9,10 
        
section .bss 
array3 resb 100 

section .text 
; loop iteration count 
_start: 
    mov ECX,ROWS 
    mov EBX,0 
    mov ESI,0 
    mov AH,0 
    mov DH,0 

sum_loop: 
    mov AL, [array1 + EBX + ESI] 
    mov DL, [array2 + EBX + ESI]
    add AL, DL
    mov [array3 + EBX + ESI], AL
    inc ESI
    cmp ESI, COLUMNS
    jb sum_loop
    add EBX, COLUMNS
    mov ESI, 0
    loop sum_loop
    
    mov eax, 1
    mov ebx, 0
    int 80h