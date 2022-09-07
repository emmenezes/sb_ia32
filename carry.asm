section .data
a   dq 0x8FFFFFFF   ; tem carry
;a  dq 0xFFFFFFFF   ; n tem carry (-1)
b   db 26



section .bss
c   resb 1

section .text
global _start

_start:
    mov eax, [a]
    mov ebx, [b]
    cdq
    imul ebx
k:  jnc l
    mov eax, 1  
    mov ebx, 0
    int 80h
l:
    mov eax, 1
    mov ebx, 0
    int 80h