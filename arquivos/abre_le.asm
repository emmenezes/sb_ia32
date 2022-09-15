section .data  
arquivo db "teste.txt"

section .bss
entrada resb 30

section .text
global _start
_start:
    ; para abrir o arquivo no modo escrita
    mov eax, 5
    mov ebx, arquivo
    mov ecx, 0x2
    mov edx, 0644
    int 80h

    ; para ler no arquivo
    mov ebx, eax
    mov eax, 3
    mov ecx, entrada
    mov edx, 30
    int 80h

    ; para imprimir texto do arquivo
    mov eax, 4
    mov ebx, 0
    mov ecx, entrada
    mov edx, 30
    int 80h

    ; para fechar o arquivo
    mov eax, 6
    int 80h

    ; para fechar o programa
    mov eax, 1
    mov ebx, 0
    int 80h