;TITLE    Sorting an array by insertion sort    INS_SORT.ASM
;
;        Objective: To sort an integer array using insertion sort.
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
        sub     EDX,array    ; EDX := array size in bytes
        shr     DX,1         ; divide by 2 to get array size
        push    DX           ; push array size & array pointer
        push    array
        call    insertion_sort
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
; using insertion sort. All registers are preserved.
;-----------------------------------------------------------
.CODE
%define   SORT_ARRAY   EBX
insertion_sort: 
       pushad                ; save registers
       mov     EBP,ESP
       mov     EBX,[EBP+36]  ; copy array pointer
       mov     CX,[EBP+40]   ; copy array size
       mov     ESI,2         ; array left of ESI is sorted
for_loop:
       ; variables of the algorithm are mapped as follows.
       ; DX = temp, ESI = i, and EDI = j
       mov     DX,[SORT_ARRAY+ESI] ; temp := array[i]
       mov     EDI,ESI       ; j := i-1
       sub     EDI,2
while_loop:
       cmp     DX,[SORT_ARRAY+EDI]  ; temp < array[j]
       jge     exit_while_loop
       ; array[j+1] := array[j]
       mov     AX,[SORT_ARRAY+EDI]
       mov     [SORT_ARRAY+EDI+2],AX
       sub     EDI,2         ; j := j-1
       cmp     EDI,0         ; j >= 0
       jge     while_loop
exit_while_loop:
       ; array[j+1] := temp
       mov     [SORT_ARRAY+EDI+2],DX
       add     ESI,2         ; i := i+1
       dec     CX
       cmp     CX,1          ; if CX = 1, we are done
       jne     for_loop
sort_done:
       popad                  ; restore registers
       ret     6
