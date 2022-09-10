; Aula 15 - Slide 12

%include "io.mac"

.DATA
char_prompt db  "Please input a character: ", 0
out_msg1    db  "The ASCII code of ", 0
out_msg2    db  " in hex is ", 0
query_msg   db  "Do you want to quit (Y/N): ", 0
hex_table   db  "0123456789ABCDEF"  ; translation table

.CODE

.STARTUP

read_char:  PutStr  char_prompt
            GetCh   AL
            PutStr  out_msg1
            PutCh   AL
            PutStr  out_msg2
            
            mov     AH, AL
            mov     EBX, hex_table
            shr     AL, 4
            xlatb
            PutCh   AL
            mov     AL, AH
            and     AL, 0FH
            xlatb
            PutCh   AL
            nwln
            PutStr  query_msg
            GetCh   AL
            cmp     AL, 'Y'
            jne     read_char
done:       .EXIT

