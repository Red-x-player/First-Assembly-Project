%include"io.mac"

;#======================[Strart macros]======================#
%macro sum1 0
    PutStr get_num1
	GetInt ax
	PutStr get_num2
	GetInt bx
	add ax,bx
	PutStr sum_msg
	PutInt ax
	nwln
	nwln
	jmp main
%endmacro
%macro sub1 0
    PutStr get_num1
	GetInt ax
	PutStr get_num2
	GetInt bx
	sub ax,bx
	PutStr sub_msg
	PutInt ax
	nwln
	nwln
	jmp main
%endmacro
%macro mul1 0
    PutStr get_num1
	GetInt ax
	PutStr get_num2
	GetInt bx
	mul bx
	PutStr mul_msg
	PutInt ax
	nwln
	nwln
	jmp main
%endmacro
%macro div1 0
    PutStr get_num1
	GetInt ax
	PutStr get_num2
	GetInt bx
	div bx
	PutStr mul_msg
	PutInt ax
	nwln
	nwln
	jmp main
%endmacro
;#===================[End Macro]===========================#

;#=====================[section .data]=====================#
.DATA
assembly db "    .#.     .#### .#### ##### #.  .# #####. #    #.   .#",0xa
         db "   .# #.    #'    #'    #.    ##..## #   .# #    '#. .#'",0xa
         db "  .#####.   '###. '###. ###   # ## # #####. #      '#'",0xa
         db " .#'   '#.      #     # #.    #    # #   .# #      '#'",0xa
         db ".#'     '#. ####' ####' ##### #    # #####' ###### '#'    Wrote By: mozzamil Eltayeeb",0xa,0xa,0


choose_msg  db "[1] calculator",0xa
            db "[2] AND bitwise",0xa
            db "[3] OR bitwise",0xa
            db "[4] XOR bitwise",0xa
            db "[5] ASCII to Decimal",0xa
            db "[6] Decimal to ASCII",0xa
            db "[7] Exit",0xa,0xa
            db "[-]Choose one from the list: ",0

;Messages to get the two numbers from user
get_num1 db "[-]Enter the first number: ",0
get_num2 db "[-]Enter the second number: ",0

;Messages to get all string from user
get_dec db "[-]Enter your decimal : ",0
ascii_str db "[-]Enter your ASCII text: ",0
str_len db "[-]Enter your string length: ",0
ascii_after_conv db "[-]Your ASCII code is: ",0

;Messages used with bitwise operations
xor_msg db " XOR ",0
or_msg db " OR ",0
and_msg db " AND ",0
is_a db " is_a ",0

;Messages used with calculator
choose_op db "[-]Choose operation [+|-|*|/]: ",0
sum_msg db "[-]The sum is: ",0
sub_msg db "[-]The sub is: ",0
mul_msg db "[-]The mul is: ",0


;#========================[section .bss]=========================#
.UDATA
user_input resb 1
num1 resw 1
num2 resw 1
ascii_string resb 255
char resb 1


;#=======================[section .code]=========================#
.CODE
.STARTUP
	PutStr assembly
main:
	PutStr choose_msg       ;Get the choose from user
	GetStr user_input
	mov eax,[user_input]
	
	cmp eax,'1'             ;compare the input with the true number
	je calculator
	cmp eax,'2'
	je and
	cmp eax,'3'
	je or
	cmp eax,'4'
	je xor
	cmp eax,'5'
	je ascii_to_dec
	cmp eax,'6'
	je dec_to_ascii
	.EXIT

;#=======================[num1 calculator]=========================#
calculator:
    PutStr choose_op        ;get input form user
    GetStr user_input
    mov eax,[user_input]

    cmp al,'+'              ;compare the input to choose the right operation
    je sum
    cmp ax,'-'
    je sub
    cmp ax,'*'
    je mul
    jmp div
sum:
    sum1
sub:
    sub1
mul:
    mul1
div:
    div1
    
;#=======================[AND bitwise]=========================#
and:
	PutStr get_num1     ;Get two input from user
	GetInt ax
	Push ax
	PutStr get_num2
	GetInt bx
	
	call ascii_to_bin   ;Print the inputs in binary and show the result
	PutStr and_msg
	mov ax,bx
	call ascii_to_bin
	PutStr is_a
	pop ax
	and ax,bx
	call ascii_to_bin
	nwln
	nwln
    jmp main
    
;#=======================[OR bitwise]=========================#
or:
	PutStr get_num1     ;Get two input from user
	GetInt ax
	Push ax
	PutStr get_num2
	GetInt bx
	
	call ascii_to_bin   ;Print the inputs in binary and show the result
	PutStr or_msg
	mov ax,bx
	call ascii_to_bin
	PutStr is_a
	pop ax
	or ax,bx
	call ascii_to_bin
	nwln
	nwln
	jmp main
;#=======================[XOR bitwise]=========================#
xor:
	PutStr get_num1     ;Get two input from user 
	GetInt ax
	Push ax
	PutStr get_num2
	GetInt bx
	
	call ascii_to_bin   ;Print the inputs in binary and show the result
	PutStr xor_msg
	mov ax,bx
	call ascii_to_bin
	PutStr is_a
	pop ax
	xor ax,bx
	call ascii_to_bin
	nwln
	nwln
	jmp main
;#=======================[ASCII to Decimal]=========================#
ascii_to_dec:
	PutStr str_len          ;Get inputs from user
	GetInt cx
	PutStr ascii_str
	GetStr ascii_string
	
	mov esi,ascii_string    ;mov one char to char variable to print
	mov edi,char
	cld
loop:
	movsb
	PutInt [char]
	nwln
	dec edi
	loop loop
	nwln
	nwln
    jmp main

;#=======================[Decimal to ASCII]=========================#
dec_to_ascii:
	PutStr get_dec          ;Get the input from the user and print it
	GetInt ax
	add ax,'0'
	mov [char],ax
	PutStr ascii_after_conv
	PutStr char
	nwln
	nwln
	jmp main

;#=======================[ASCII to Binary]=========================#
ascii_to_bin:
	mov AH,80H
	mov ECX,8

print_bit:
	test AL,AH
	jz   print_0
	PutCh '1'
	jmp   skip1

print_0:
	PutCh '0'

skip1:
	shr  AH,1
	loop print_bit
	ret
