;Bubble sort procedure     BBLSORT.ASM
;	Objective: To implement the bubble sort algorithm.
;	    Input: A set of nonzero integers to be sorted.
;		     Input is terminated by entering zero.
;        Output: Outputs the numbers in ascending order.

%define    CRLF  0DH,0AH
MAX_SIZE   EQU   20
%include "io.mac"
.DATA
prompt_msg  db  "Enter nonzero integers to be sorted.",CRLF
	      db  "Enter zero to terminate the input.",0
output_msg  db  "Input numbers in ascending order:",0

.UDATA
array       resw  MAX_SIZE     ; input array for integers

.CODE
      .STARTUP
      PutStr  prompt_msg     ; request input numbers
      nwln
      mov     EBX,array      ; EBX := array pointer
      mov     CX,MAX_SIZE    ; CX := array size
      sub     DX,DX          ; number count := 0
read_loop:
      GetInt  AX             ; read input number
      cmp     AX,0           ; if the number is zero
      je      stop_reading   ; no more numbers to read
      mov     [EBX],AX       ; copy the number into array
      add     EBX,2          ; EBX points to the next element
      inc     DX             ; increment number count
      loop    read_loop      ; reads a max. of MAX_SIZE numbers
stop_reading:
      push    DX             ; push array size onto stack
      push    array          ; place array pointer on stack
      call    bubble_sort
      PutStr  output_msg     ; display sorted input numbers
      nwln
      mov     EBX,array
      mov     CX,DX          ; CX := number count
print_loop:
      PutInt  [EBX]
      nwln
      add     EBX,2
      loop    print_loop
done:
      .EXIT
;-----------------------------------------------------------
;This procedure receives a pointer to an array of integers
; and the size of the array via the stack. It sorts the
; array in ascending order using the bubble sort algorithm.
;-----------------------------------------------------------
.CODE
SORTED    EQU   0
UNSORTED  EQU   1
bubble_sort:
      pushad
      mov     EBP,ESP
	
      ;CX serves the same purpose as the end_index variable
      ; in the C procedure. CX keeps the number of comparisons
      ; to be done in each pass. Note that CX is decremented
      ; by 1 after each pass.
      mov     CX, [EBP+40]  ; load array size into CX
      mov     BX, [EBP+36]  ; load array address into BX

next_pass:
      dec     CX           ; if # of comparisons is zero
      jz      sort_done         ; then we are done
      mov     DI,CX        ; else start another pass

      ;DX is used to keep SORTED/UNSORTED status
      mov     DX,SORTED    ; set status to SORTED

      ;ESI points to element X and ESI+2 to the next element
      mov     ESI,EBX      ; load array address into ESI
pass:
      ;This loop represents one pass of the algorithm.
      ;Each iteration compares elements at [ESI] and [ESI+2]
      ; and swaps them if ([ESI]) < ([ESI+2]).
      mov     AX,[ESI]
      cmp     AX,[ESI+2]
      jg      swap
increment:
      ;Increment ESI by 2 to point to the next element
      add     ESI,2
      dec     DI
      jnz     pass 
	
      cmp     DX,SORTED       ; if status remains SORTED
      je      sort_done       ; then sorting is done
      jmp     next_pass       ; else initiate another pass

swap:
      ; swap elements at [ESI] and [ESI+2]
      xchg    AX,[ESI+2]
      mov     [ESI],AX
      mov     DX,UNSORTED     ; set status to UNSORTED
      jmp     increment       

sort_done:
      popad     
      ret     6               ; return and clear parameters
