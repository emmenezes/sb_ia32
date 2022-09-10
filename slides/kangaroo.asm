section .data
Snippet db 'KANGAROO', 0dH, 0ah
section .text
global _start
_start: mov eax, 4
        mov ebx, 1
        mov ecx, Snippet
        mov edx, 10
        int 80h
        mov ebx, Snippet
        mov eax, 8
DoMore: add byte [ebx], 32
        inc ebx
        dec eax
        jnz DoMore
        mov eax, 4
        mov ebx, 1
        mov ecx, Snippet
        mov edx, 10
        int 80h
        mov eax, 1
        mov ebx, 0
        int 80h