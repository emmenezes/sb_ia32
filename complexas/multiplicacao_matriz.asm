%define RES dword   [ebp-4]

section .data
a   db  1,2,3,4,5,6,7,8,9,10
b   db  -1,10,-3,8,-5,6,-7,4,-9,2

section .text
global _start
_start:
    push    word    10
    push    b
    push    a
    call    f4

    mov     eax,    1
    mov     ebx,    0
    int     80h

f4:
    push    ebp
    mov     ebp,    esp
    push    ebx
    push    ecx
    push    edx

    mov     ebx,    0
    sub     ebx,    ebx
    sub     ecx,    ecx
    mov     cx,     [ebp+16]    ; pega a quantidade de valores
j:
    mov     edx,    [ebp+8]     ; pega o endereço de a
    add     edx,    ebx         ; soma com o índice ebx
    mov     al,     [edx]       ; pega o valor do ponteiro de a
    cbw
    mov     edx,    [ebp+12]    ; pega o endereço de b
    add     edx,    ebx         ; soma com o índice ebx
k:    
    imul    byte    [edx]       ; multiplica pelo valor do ponteiro de b
    cwde                        ; extende de 16 bits para 32
    add     RES,    eax         ; soma à variável local
    inc     ebx                 ; incrementa o índice ebx
    loop    j

    mov     eax,    RES         ; ao fim, salva o valor final em eax
l:
    pop     edx
    pop     ecx
    pop     ebx
    pop     ebp
    ret     10

