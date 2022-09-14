section .data
n dq 12

section .text
global _start
_start:
    mov eax, [n]
    shl eax, 1
    mov ebx, eax
    shl eax, 2
    add eax, ebx

f:
    mov eax, 1
    mov ebx, 0
    int 80h    

