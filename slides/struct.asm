; struct curso{
;     int code;       4 bytes
;     int limit;      4 bytes
;     int registered; 4 bytes
;     int romm;       4 bytes
;                 =   16 bytes
; }

%define code        0
%define limit       4
%define registered  8
%define room        12

global _start

section .bss
struct resb 16

section .data
msg1    db  "Entre com codigo do curso ", 0
size_msg1   equ $-msg1
msg2    db  "Entre com o limite de alunos ", 0
sige_msg2   equ $-msg2
msg3    db  "Entre com o numero de alunos matriculados ", 0
size_msg3   equ $-msg3
msg4    db  "Entre com numero da sala ", 0
size_msg4   equ $-msg4

section .bss
response    resb 2

section .text
_start:
    ; imprime msg1
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, size_msg1
    int 80h

    ; pega resposta
    mov eax, 3
    mov ebx, 0
    mov ecx, response
    mov edx, 2
    int 80

    ; salva code na struct
    mov ebx, 0
    mov bl,  [response]
    sub bl,  0x30
    mov eax, struct
    mov dword   [eax+code], ebx
    
    ; imprime msg2
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, size_msg2
    int 80h

    ; pega resposta
    mov eax, 3
    mov ebx, 0
    mov ecx, response
    mov edx, 2
    int 80

    ; salva code na struct
    mov ebx, 0
    mov bl,  [response]
    sub bl,  0x30
    mov eax, struct
    mov dword   [eax+limit], ebx

    ; imprime msg3
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, size_msg3
    int 80h

    ; pega resposta
    mov eax, 3
    mov ebx, 0
    mov ecx, response
    mov edx, 2
    int 80

    ; salva code na struct
    mov ebx, 0
    mov bl,  [response]
    sub bl,  0x30
    mov eax, struct
    mov dword   [eax+registered], ebx

    ; imprime msg4
    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, size_msg4
    int 80h

    ; pega resposta
    mov eax, 3
    mov ebx, 0
    mov ecx, response
    mov edx, 2
    int 80

    ; salva code na struct
    mov ebx, 0
    mov bl,  [response]
    sub bl,  0x30
    mov eax, struct
    mov dword   [eax+room], ebx

    mov eax, 1
    mov ebx, 0
    int 80h