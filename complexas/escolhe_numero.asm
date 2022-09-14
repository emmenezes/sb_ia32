section .bss
a resd 1

section .text
global _start
_start:
    call getVal
    mov [a], eax

f:
    mov eax, 1
    mov ebx, 0
    int 80h

getVal:
    push ebp            ; enter 0,0
    mov ebp, esp
    mov dword [ebp-2], 0

l:  ; seto os outros registradores para a chamada
    mov ecx, ebp ; coloco o endereço de var em ecx
    sub ecx, 3
    mov eax, 3
    mov ebx, 0
    mov edx, 1
    int 80h

    mov bl, [ecx]
    cmp bl, 0x41
    jne op1
    add word [ebp-2], 1
    mov ax, [ebp-2]
    jmp l
op1:
    mov bl, [ecx]
    cmp bl, 0x42
    jne op2
    sub word [ebp-2], 1
    mov ax, [ebp-2]
    jmp l

op2:
    mov eax, 0
    mov ax, [ebp-2]
g:
    pop ebp
    ret