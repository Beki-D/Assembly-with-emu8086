; Program to perform 4 arithmetic operations in EMU8086 Assembly

org 100h

; Input prompt 1
mov dx, offset prompt
mov ah, 9
int 21h

; Read first number
mov ah, 1
int 21h
sub al, 48
mov bl, al

; Input prompt 2
mov dx, offset prompt
mov ah, 9
int 21h

; Read second number
mov ah, 1
int 21h
sub al, 48
mov cl, al

; Input prompt for operation choice
mov dx, offset op_prompt
mov ah, 9
int 21h

; Read operation
mov ah, 1
int 21h

; Check operation
cmp al, '1'
jne not_add
; addition
add bl, cl
jmp display

not_add:
cmp al, '2'
jne not_sub
; subtraction
mov ah, 0
sub bl, cl
jnc display
neg bl
jmp display

not_sub:
cmp al, '3'
jne not_mul
; multiplication
mov bh, 0
mov al, bl
mul cl
mov bl, al
jmp display

not_mul:
cmp al, '4'
jne not_div
; division
xor dx, dx
mov ax, bx
cwd
idiv cl
mov bl, al
jmp display

not_div:
; Invalid operation
mov dx, offset invalid
mov ah, 9
int 21h
jmp end

display:
;Display result on new line
mov dx, offset new_line
mov ah, 9
int 21h

; Check for negative result
jc display_minus
back:

; Display result
mov dl, bl
add dl, 48
mov ah, 2
int 21h

end:
; End program
mov ah, 4ch
int 21h

display_minus:
; result is negative, display "-"
mov dl, '-'
mov ah, 2
int 21h
jmp back 

;retrun control to OS, ending the program
mov ah, 4ch
int 21h


prompt db 0Ah, 0Dh, 'Enter a number: $', 0
op_prompt db 0Ah, 0Dh, 'Enter the operation (1-Add, 2-Subtract, 3-Multiply, 4-Divide): $', 0
invalid db 0Ah, 0Dh, 'Invalid operation!$', 0
new_line db 0Ah, 0Dh, 'Result: $', 0