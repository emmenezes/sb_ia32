;Sorting an array by selection sort    SEL_SORT.ASM
;
;        Objective: To sort an integer array using selection sort.
;            Input: Requests numbers to fill array.
;           Output: Displays sorted array.
%include "io.mac"

.DATA
MAX_SIZE       EQU 100
input_prompt   db  "Please enter input array: "
               db  "(negative number terminates input)",0
out_msg        db  "The sorted array is:",0

.UDATA
array          resw  MAX_SIZE

.CODE
        .STARTUP
        PutStr  input_prompt ; request input array
        mov     EBX,array
        mov     CX,MAX_SIZE
array_loop:
        GetInt  AX           ; read an array number
        cmp     AX,0         ; negative number?
        jl      exit_loop    ; if so, stop reading numbers
        mov     [EBX],AX     ; otherwise, copy into array
        add     EBX,2        ; increment array address
        loop    array_loop   ; iterates a maximum of MAX_SIZE
exit_loop:
        mov     EDX,EBX      ; EDX keeps the actual array size
        sub     EDX,array    ; EDX = array size in bytes
        sar     EDX,1        ; divide by 2 to get array size
        push    DX           ; push array size & array pointer
        push    array
        call    selection_sort
        PutStr  out_msg      ; display sorted array
        nwln
        mov     CX,DX
        mov     EBX,array
display_loop:
        PutInt  [EBX]
        nwln
        add     EBX,2
        loop    display_loop
done:                        
        .EXIT

;-----------------------------------------------------------
; This procedure receives a pointer to an array of integers
; and the array size via the stack. The array is sorted by
; using the selection sort. All registers are preserved.
;-----------------------------------------------------------
%define SORT_ARRAY  EBX
selection_sort:
       pushad                ; save registers
       mov     EBP,ESP
       mov     EBX,[EBP+36]  ; copy array pointer
       mov     CX,[EBP+40]   ; copy array size
       sub     ESI,ESI       ; array left of SI is sorted
sort_outer_loop:
       mov     EDI,ESI
       ; DX is used to maintain the minimum value and AX
       ; stores the pointer to the minimum value
       mov     DX,[SORT_ARRAY+ESI]  ; min. value is in DX
       mov     EAX,ESI       ; EAX = pointer to min. value
       push    CX
       dec     CX            ; size of array left of ESI
sort_inner_loop:
       add     EDI,2         ; move to next element
       cmp     DX,[SORT_ARRAY+EDI] ; less than min. value?
       jle     skip1         ; if not, no change to min. value
       mov     DX,[SORT_ARRAY+EDI] ; else, update min. value (DX)
       mov     EAX,EDI       ;       & its pointer (EAX)
skip1:
       loop    sort_inner_loop
       pop     CX
       cmp     EAX,ESI       ; EAX = ESI?
       je      skip2         ; if so, element at ESI is its place
       mov     EDI,EAX       ; otherwise, exchange
       mov     AX,[SORT_ARRAY+ESI]  ; exchange min. value 
       xchg    AX,[SORT_ARRAY+EDI]  ; & element at ESI
       mov     [SORT_ARRAY+ESI],AX
skip2:
       add     ESI,2         ; move SI to next element
       dec     CX
       cmp     CX,1          ; if CX = 1, we are done
       jne     sort_outer_loop
       popad                  ; restore registers
       ret     6
