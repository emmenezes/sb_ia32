; int main() {
;   int i = 0;
;   while (i < 100) {
;       printf("%d", i);
;       i++;
;   }
;}

%include "io.mac"

.DATA
i   dw  0
max equ 100

.CODE
.STARTUP
    mov     ECX,    max
lp: 
    PutCh   0x20
    PutInt  [i]
    inc     word    [i]
    loop    lp
.EXIT