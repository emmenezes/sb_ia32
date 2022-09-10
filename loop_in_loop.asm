; int main() {
;     int i, j;
;     for (i = 0; i < 4; i++)
;         for (j = 0; j < 2; j++)
;             printf("i: %d j: %d\n", i, j);
; }

%include "io.mac"

.DATA
i       db  0
MAXI    equ 4
MAXJ    equ 2

.UDATA
j   resb    1

.CODE
.STARTUP

lpi:
    mov BYTE    [j],    0
lpj:
    PutInt  [i]
    PutCh   0x20    ; caractere de espaço
    PutInt  [j]
    PutCh   0xA     ; caractere de nova linha
    inc BYTE    [j]
    cmp BYTE    [j],    MAXJ
    jb  lpj
    inc BYTE    [i]
    cmp BYTE    [i],    MAXI
    jb  lpi

.EXIT
