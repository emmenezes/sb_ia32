;Fibonacci numbers (register version)    PROCFIB1.ASM
;
;        Objective: To compute Fibinacci number using registers
;                   for local variables.
;            Input: Requests a positive integer from the user.
;           Output: Outputs the largest Fibonacci number that
;                   is less than or equal to the input number.

%include "io.mac"

.DATA
prompt_msg   db  "Please input a positive number (>1): ",0
output_msg1  db  "The largest Fibonacci number less than "
             db  "or equal to ",0
output_msg2  db  " is ",0

.CODE
      .STARTUP
      PutStr  prompt_msg     ; request input number
      GetInt  DX             ; DX = input number
      call    fibonacci
      PutStr  output_msg1    ; display Fibonacci number
      PutInt  DX
      PutStr  output_msg2
      PutInt  AX
      nwln
done:
      .EXIT

;-----------------------------------------------------------
;Procedure fibonacci receives an integer in DX and computes
; the largest Fibonacci number that is less than or equal to
; the input number. The Fibonacci number is returned in AX.
;-----------------------------------------------------------
.CODE
fibonacci:
      push    BX
      ; AX maintains the smaller of the last two Fibonacci
      ;  numbers computed; BX maintains the larger one.
      mov     AX,1           ; initialize AX and BX to
      mov     BX,AX          ;  first two Fibonacci numbers
fib_loop:
      add     AX,BX          ; compute next Fibonacci number
      xchg    AX,BX          ; maintain the required order
      cmp     BX,DX          ; compare with input number in DX
      jle     fib_loop       ; if not greater, find next number
      ; AX contains the required Fibonacci number
      pop     BX
      ret
