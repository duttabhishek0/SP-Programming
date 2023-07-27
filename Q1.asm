section .data
    result_message db "The 7th Fibonacci number is: ", 0
    newline db 7
    space db " "

section .bss
    fibonacci_number resb 11  

section .text
    global main

main:
    mov eax, 0   
    mov ebx, 1   
    mov ecx, 10   

fibonacci_loop:
    add eax, ebx   
    xchg eax, ebx  
    loop fibonacci_loop

    
    mov ecx, fibonacci_number + 10  
    mov byte [ecx], 0               
    mov ebx, 10                     

convert_loop:
    dec ecx                          
    xor edx, edx                
    div ebx                         
    add dl, '0'                     
    mov [ecx], dl                   
    test eax, eax               
    jnz convert_loop                
    lea edx, [fibonacci_number + 10] 
    sub edx, ecx        

    mov eax, 4
    mov ebx, 1
    mov ecx, result_message
    add edx, 30         
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, fibonacci_number
    mov edx, edx                
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80


    mov eax, 1
    xor ebx, ebx
    int 0x80