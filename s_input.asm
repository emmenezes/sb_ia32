section .data
dop2 db 10d

section .bss
dop1 resb 20

section .text
global _start
_start:
    push dop1
    push word 10
    call s_input

    mov eax, 4
    mov ebx, 1
    mov ecx, dop1
    mov edx, 10
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h

s_input:
    push ebp
    mov ebp, esp
    push eax
    sub edx, edx
    
    mov eax, 3
    mov ebx, 0
    mov ecx, [ebp+10]
    mov dx, [ebp+8]
k:
    int 80h

    pop eax
    pop ebp
    ret 10