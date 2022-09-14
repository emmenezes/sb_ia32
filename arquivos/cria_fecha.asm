section .data

nome db "teste.txt"

section .text
global _start
_start:
    mov eax, 8
    mov ebx, nome
    mov ecx, 0644
    int 80h

    mov ebx, eax
    mov eax, 6
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h