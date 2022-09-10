section     .data
dop2    dw  10d

section     .bss
dop1    resb 20

section     .text
global _start
_start:
    push    word    [dop2]
    push    dop1
    call    s_input

    mov     eax,    4
    mov     ebx,    1
    mov     ecx,    dop1
    mov     edx,    10
    int     80h

    mov     eax,    1
    mov     ebx,    0
    int     80h

s_input:
    push    ebp
    mov     ebp,    esp
    push    eax
    sub     edx,    edx
    
    mov     eax,    3
    mov     ebx,    0
    mov     ecx,    [ebp+8]
    mov     dx,     [ebp+12]
k:
    int     80h

    pop     eax
    pop     ebp
    ret     10