section .data
msg     db "Mais um dia, mais um teste", 0Dh, 0Ah
MSGSIZE EQU $-msg    
arquivo db "teste.txt"

section .text
global _start
_start:
    ; para abrir o arquivo no modo escrita
    mov eax, 5
    mov ebx, arquivo
    mov ecx, 0x1
    mov edx, 0644
    int 80h

    ; para escrever no arquivo
    mov ebx, eax
    mov eax, 4
    mov ecx, msg
    mov edx, MSGSIZE
    int 80h

    ; para fechar o arquivo
    mov eax, 6
    int 80h

    ; para fechar o programa
    mov eax, 1
    mov ebx, 0
    int 80h