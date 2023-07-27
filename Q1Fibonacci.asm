; 	global main
; 	extern printf

; 	section .data
; format:	db '%15ld', 10, 0
; title:	db 'fibinachi numbers', 10, 0
	
; 	section .text
; main:
; 	push rbp 		
; 	mov rdi, title 		
; 	mov rax, 0 		
; 	call printf

; 	mov rcx, 95 		
; 	mov rax, 1 		
; 	mov rbx, 2 		
; print:
; 	push rax 		
; 	push rcx 		
; 	mov rdi, format 	
; 	mov rsi, rax 		
; 	mov eax, 0 		
; 	
; 	pop rcx
; 	pop rax
; 	mov rdx, rax 		
; 	mov rax, rbx 		
; 	add rbx, rdx 		
; 	dec rcx 		
; 	jnz print 		
; 	pop rbp 		
; 	mov rax, 0		
; 	ret

section .data
    n equ 1

    result db "The nth fibonacci number is: ", 0
    result_len equ $ - result

section .bss
    fib resd 1 

section .text
    global _start

_start:
    mov dword [fib], 0
    mov dword [fib + 4], 1
    mov eax, n
    cmp eax, 1
    jbe end_prog

    mov ecx, 2        
    mov ebx, 1        
    jmp fib_loop
fib_loop:
    add ebx, dword [fib]  
    mov dword [fib], ebx  
    sub eax, 1            
    cmp eax, 1
    jbe end_prog

    inc ecx            
    jmp fib_loop

end_prog:
    mov eax, 4
    mov ebx, 1
    mov edx, result_len
    mov ecx, result
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov edx, 4
    mov ecx, [fib]
    int 0x80

    mov eax, 1           
    xor ebx, ebx        
    int 0x80             

