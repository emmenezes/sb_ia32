section .data
name_msg    db  'Please enter your name: '
NAMESIZE    EQU $-name_msg
query_msg   db  'How many times to repeat welcome message? '
QUERYSIZE   EQU $-query_msg
welcome_msg db  'Welcome do Assembly Language Programming '
WELCSIZE    EQU $-welcome_msg
nwln        db  0Dh, 0Ah
NWLNSIZE    EQU $-nwln

section .bss
user_name   resb    16
response    resb    1

section .text
global _start
_start:
    ; Imprime name_msg
    mov eax, 4
    mov ebx, 1
    mov ecx, name_msg       ; 'Please enter your name: '
    mov edx, NAMESIZE
    int 80h

    ; Pega user_name
    mov eax, 3
    mov ebx, 0
    mov ecx, user_name
    mov edx, 16
    int 80h

    ; Imprime query_msg
    mov eax, 4
    mov ebx, 1
    mov ecx, query_msg      ;'How many times to repeat welcome message? '
    mov edx, QUERYSIZE
    int 80h

    ; Pega response
    mov eax, 3
    mov ebx, 0
    mov ecx, response
    mov edx, 1
    int 80h
    
    ; Converte de string para int
    mov ECX, 0
    mov CL, [response]
    sub CL, 0x30

display_msg:
    ; Imprime welcome_msg com user_name
    push ECX
    mov eax, 4
    mov ebx, 1
    mov ecx, welcome_msg
    mov edx, WELCSIZE
    int 80h
    mov eax, 4
    mov ebx, 1
    mov ecx, user_name
    mov edx, 16
    int 80h
    ; mov eax, 4
    ; mov ebx, 1
    ; mov ecx, nwln
    ; mov edx, NWLNSIZE
    ; int 80h

    ; Atualiza contador e faz loop
    pop ECX
    loop display_msg

    ; Encerra programa
    mov eax, 1
    mov ebx, 0
    int 80h