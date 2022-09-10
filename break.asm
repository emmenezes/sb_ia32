; int main() {
;     int i, j;
;     for (i = 0; i < 4; i++)
;         for (j = 0; j < 2; j++)
;             if (i == 1) break;
;             else printf("i: %d j: %d\n", i, j);
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
    cmp BYTE    [i],    1
    je  lpi2
    PutInt  [i]
    PutCh   0x20
    PutInt  [j]
    PutCh   0xA
    inc BYTE    [j]
    cmp BYTE    [j],    MAXJ
    jb  lpj
lpi2:
    inc BYTE    [i]
    cmp BYTE    [i],    MAXI
    jb  lpi

.EXIT