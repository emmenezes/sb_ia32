;Variable number of parameters passed via stack   VARPARA.ASM
;
;        Objective: To show how variable number of parameters 
;                   can be passed via the stack.
;            Input: Requests variable number of nonzero integers.
;                   A zero terminates the input.
;           Output: Outputs the sum of input numbers.

%define CRLF   0DH,0AH    ; carriage return and line feed
	
%include "io.mac"

.DATA
prompt_msg  db  "Please input a set of nonzero integers.",CRLF
            db  "You must enter at least one integer.",CRLF
            db  "Enter zero to terminate the input.",0
sum_msg     db  "The sum of the input numbers is: ",0

.CODE
      .STARTUP
      PutStr  prompt_msg     ; request input numbers
      nwln
      sub     CX,CX          ; CX keeps number count
read_number:
      GetInt  AX             ; read input number
      cmp     AX,0           ; if the number is zero
      je      stop_reading   ; no more nuumbers to read
      push    AX             ; place the number on stack
      inc     CX             ; increment number count
      jmp     read_number
stop_reading:
      push    CX             ; place number count on stack
      call    variable_sum   ; returns sum in AX
      ; clear parameter space on the stack
      inc     CX             ; increment CX to include count
      add     CX,CX          ; CX = CX * 2 (space in bytes)
      add     SP,CX          ; update SP to clear parameter 
                             ; space on the stack      
      PutStr  sum_msg        ; display the sum
      PutInt  AX
      nwln
done:
      .EXIT

;-----------------------------------------------------------
;This procedure receives variable number of integers via the
; stack. The last parameter pushed on the stack should be
; the number of integers to be added. Sum is returned in AX.
;-----------------------------------------------------------
.CODE
variable_sum:
      enter   0,0
      push    EBX            ; save EBX and ECX
      push    ECX 
      
      mov     CX,[EBP+8]     ; CX = # of integers to be added
      mov     EBX,EBP
      add     EBX,10         ; BX = pointer to first number
      sub     AX,AX          ; sum = 0
add_loop:
      add     AX,[SS:EBX]    ; sum = sum + next number
      add     EBX,2          ; BX points to the next integer
      loop    add_loop       ; repeat count in CX

      pop     ECX            ; restore registers
      pop     EBX
      leave
      ret                    ; parameter space cleared by main
