%include "io.mac"

.DATA
op1 DQ 371026A812579AE7H
op2 DQ 489BA321FE604213H

.UDATA
result RESQ 1

.CODE
.STARTUP

    mov DWORD   EAX,        [op1+4]
    mov DWORD   EBX,        [op1]
    mov DWORD   ECX,        [op2+4]
    mov DWORD   EDX,        [op2]
j:  add         EBX,        EDX
k:  adc         EAX,        ECX
l:  mov DWORD   [result],   EBX
    mov DWORD   [result+4], EAX

.EXIT