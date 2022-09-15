section .data
msg     db "por que isso nao ta dando certo?", 0ah
nome    db 'outro_teste.txt', 0
MSGSIZE EQU $-msg

section .text
global _start
_start:
    ; cria arquivo
    mov eax, 8
    mov ebx, nome
    mov ecx, 0644
    int 80h

    ; escreve no arquivo
    mov ebx, eax
    mov eax, 4
    mov ecx, msg
    mov edx, MSGSIZE
    int 80h

    ; fecha arquivo
    mov eax, 6
    int 80h

    ; fecha programa
    mov eax, 1
    mov ebx, 0
    int 80h
