%include "io.mac"

.DATA
msg db "Please input a string: ", 0

.UDATA
string1        resb 20
string_reversa resb 20

.CODE
.STARTUP

main:
    PutStr msg
    GetStr string1, 20
    
    mov eax, string1
    mov ebx, 0 ;tamanho
    mov edx, string_reversa

    ;loop responsavel por mover o ponteiro ate o final da string
    loop1:
        mov cl, [eax] ;pega o char
        cmp cl, 0 ;compara se chegou ao fim da string
        jz  loop2 ;pula pro loop2
        inc eax ;+1 no ponteiro
        inc ebx ;+1 no tamanho
        jmp loop1

    ;loop responsavel por pecorrer a string inversa copiando cada char pra string_reversa
    loop2:
        dec eax ; decrementa o ponteiro da string original
        mov cl, [eax] ;pegar o char
        dec ebx ;decrementa o tamanho 
        cmp ebx, -1 ;compara se chegou no incio da string
        je fim 
        mov [edx], byte cl ;copia o char lido pra edx = string_reversa
        inc edx ;aumenta o ponteiro de edx 
        jmp loop2
    
    fim:
        PutStr string_reversa
        nwln
        .EXIT
