%define FIB_LO dword [EBP-4]
%define FIB_HI dword [EBP-8]

section .text
global _start
_start:
    mov edx, 5
    call fibonacci
    mov eax, 1
    mov ebx, 0
    int 80h

fibonacci:
    enter 8,0
    push EBX
    mov FIB_LO, 1
    mov FIB_HI, 1

fib_loop:
    mov EAX, FIB_HI
    mov EBX, FIB_LO
    add EBX, EAX
    mov FIB_LO, EAX
    mov FIB_HI, EBX
    cmp EBX, EDX
f:
    jle fib_loop
    pop EBX
    leave
    ret


