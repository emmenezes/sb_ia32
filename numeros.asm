section .data
num_msg     db  'Por favor, insira um numero: '
NUMSIZE    EQU $-num_msg
nwln        db  0Dh, 0Ah
NWLNSIZE    EQU $-nwln

section .bss
numero      resb    32
numeros     resb    32
i           resb    1
c           resb    1

section .text
global _start
_start:
    ; Imprime num_msg
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, num_msg       ; 'Please enter your name: '
    mov     edx, NUMSIZE
    int     80h

    ; Pega numero
    mov     eax, 3
    mov     ebx, 0
    mov     ecx, numero
    mov     edx, 32
    int     80h

    ; Salva em eax, o valor total
    mov     eax, 0
    mov     ebx, numero
    mov     ecx, 0
loopi:
    ; recebe o dígito e confere se é o fim
    mov     cl, [ebx]
    cmp     cl, 0Dh
    jz      saida
    cmp     cl, 0Ah
    jz      saida
    cmp     cl, 00h
    jz      saida
    sub     cl, 30h
    mov     edx, eax

    ; edx é eax * 10
    shl     eax,3
    add     eax,edx
    add     eax,edx

    add     eax, ecx
    
    inc     ebx
    jmp     loopi

saida:
    mov     byte [i], 0
    mov     byte [c], 0
    mov     dword [numeros], 0
    mov     ecx, 10

loopo:
    sub     edx, edx
    div     ecx
    rol     dword [numeros], 8
    add     edx, 0x30
    mov     byte [numeros], dl
    ; Checa se é o fim do número
    add     byte [i], 4
    cmp     eax, 0
    mov     edx, [numeros]
    jz      imprime
    jmp     loopo    
    
imprime:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, numeros
    mov     edx, [i]
    int     80h

    mov eax, 4
    mov ebx, 1
    mov ecx, nwln
    mov edx, NWLNSIZE
    int 80h

fim:
    ; Encerra programa
    mov eax, 1
    mov ebx, 0
    int 80h
