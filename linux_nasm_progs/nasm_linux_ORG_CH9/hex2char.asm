;Hex equivalent of characters   HEX2CHAR.ASM
;
;        Objective: To print the hex equivalent of
;                   ASCII character code. Demonstrates
;                   the use of xlat instruction.
;            Input: Requests a character from keyboard.
;           Output: Prints the ASCII code of the
;                   input character in hex.
%include "io.mac"
	
.DATA
char_prompt    db  "Please input a character: ",0
out_msg1       db  "The ASCII code of '",0
out_msg2       db  "' in hex is ",0
query_msg      db  "Do you want to quit (Y/N): ",0
; translation table: 4-bit binary to hex
hex_table      db  "0123456789ABCDEF"    

.CODE
        .STARTUP
read_char:
        PutStr  char_prompt  ; request a char. input
        GetCh   AL           ; read input character

        PutStr  out_msg1
        PutCh   AL
        PutStr  out_msg2
        mov     AH,AL        ; save input character in AH
        mov     EBX,hex_table ; BX := translation table
        shr     AL,4         ; move upper 4 bits to lower half
        xlatb                ; replace AL with hex digit
        PutCh   AL           ; write the first hex digit
        mov     AL,AH        ; restore input character to AL
        and     AL,0FH       ; mask off upper 4 bits
        xlatb
        PutCh   AL           ; write the second hex digit
        nwln
        PutStr  query_msg    ; query user whether to terminate
        GetCh   AL           ; read response

        cmp     AL,'Y'       ; if response is not 'Y'
        jne     read_char    ; read another character
done:                        ; otherwise, terminate program
        .EXIT
