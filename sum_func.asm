%include "io.mac"

.DATA
prompt_msg1 db "Please input the first number: ", 0
prompt_msg2 db "Please input the second number: ", 0
sum_msg db "The sum is ", 0

.CODE
    .STARTUP
    PutStr prompt_msg1
    GetInt CX
    PutStr prompt_msg2
    GetInt DX
    call sum
    PutStr sum_msg
    PutInt AX
    nwln

done:
    .EXIT

sum:
    mov AX, CX
    add AX, DX
    ret
