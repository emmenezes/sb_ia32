section     .data
dop2    dw  13d
dop1    db  "Outro teste", 0dH, 0aH

section     .text
global _start
_start:
    push    word    [dop2]
    push    dop1
    call    s_output

    mov     eax,    1
    mov     ebx,    0
    int     80h

s_output:
    push    ebp
    mov     ebp,    esp
    push    eax
    sub     edx,    edx

    mov     eax,    4
    mov     ebx,    1
    mov     ecx,    [ebp+8]
    mov     dx,     [ebp+12]
    int     80h

    pop     eax
    pop     ebp
    ret     6