;Fibonacci numbers (stack version)    PROCFIB2.ASM
;
;        Objective: To compute Fibonacci number using the stack
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
      GetInt  DX             ; DX := input number
      call    fibonacci
      PutStr  output_msg1    ; print Fibonacci number
      PutInt  DX
      PutStr  output_msg2
      PutInt  AX
      nwln
done:
      .EXIT

;-----------------------------------------------------------
;Procedure fibonacci receives an integer in DX and computes
; the largest Fibonacci number that is less than the input
; number. The Fibonacci number is returned in AX.
;-----------------------------------------------------------
%define FIB_LO  word [EBP-2]
%define FIB_HI  word [EBP-4]
.CODE
fibonacci:
      enter   4,0            ; space for two local variables
      push    BX
      ; FIB_LO maintains the smaller of the last two Fibonacci
      ;  numbers computed; FIB_HI maintains the larger one.
      mov     FIB_LO,1       ; initialize FIB_LO and FIB_HI to
      mov     FIB_HI,1       ;  first two Fibonacci numbers
fib_loop:
      mov     AX,FIB_HI      ; compute next Fibonacci number
      mov     BX,FIB_LO
      add     BX,AX
      mov     FIB_LO,AX
      mov     FIB_HI,BX
      cmp     BX,DX          ; compare with input number in DX
      jle     fib_loop       ; if not greater, find next number
      ; AX contains the required Fibonacci number
      pop     BX
      leave                  ; clears local variable space
      ret


