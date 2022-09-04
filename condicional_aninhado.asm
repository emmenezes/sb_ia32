; Aula 16 - Slide 14
%include "io.mac"

.DATA
msg     db 'Please enter binary number: ',0
msg0    db 'Zero!',0
msg1    db 'Um!',0
msg2    db 'Dois',0
msg3    db 'Tres',0

.UDATA
number resb 3

.CODE
.STARTUP
            PutStr  msg
            GetStr  number,3
            cmp     BYTE [number],30h
            jne     doistres
            cmp     BYTE [number+1],30h
            jne     um
zero:       PutStr msg0
            jmp     Fim
um:         PutStr  msg1
            jmp     Fim
doistres:   cmp     BYTE [number+1],30h
            jne     tres
dois:       PutStr  msg2
            jmp     Fim
tres:       PutStr  msg3
Fim:        .EXIT

