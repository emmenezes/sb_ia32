; sum = 0
; for (i=max;  i > 0; i--)
;   sum += i;

%include "io.mac"

.DATA
soma    dw  0
max     equ 10

.UDATA
i   resw    1

.CODE
.STARTUP
    ; essa linha serve para pegar o endereço de soma
    ; usando gdb, use o comando x/1uw endereço para conferir os valores
    ; x - examine
    ; 1 - quantidade de valores observados
    ; u - formato de impressão para int
    ; w - unidade de tamanho word (16 bits, 2 bytes) 
    ; para mais informações, consulte: https://sourceware.org/gdb/onlinedocs/gdb/Memory.html
    mov EAX, soma       
p:
    mov WORD    [i],    max
    mov WORD    CX,     [i]
lp: 
    add [soma], CX
    loop        lp
fim:
    .EXIT