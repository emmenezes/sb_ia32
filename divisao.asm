section .data
a   dq 0x26F
b   db 26

section .bss
c   resb 1

section .text
global _start

_start:
    mov eax, [a]
    mov ebx, [b]
    cdq
    idiv ebx

f:
    mov eax, 1
    mov ebx, 0
    int 80h