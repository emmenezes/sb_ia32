; int main() {
;     int i;
;     for (i = 0; i < 5; i++) 
;         if (i == 1) continue;
;         else printf("i: %d\n", i);
; }

%include "io.mac"

.DATA
msg     db  "i: ", 0
i       db  0
MAXI    equ 5

.CODE
.STARTUP

    mov CX, MAXI
lpi:
    cmp BYTE    [i],    1
    je  lpi2
    PutStr  msg
    PutInt  [i]
    PutCh   0xA
lpi2:
    inc BYTE    [i]
    loop    lpi

.EXIT