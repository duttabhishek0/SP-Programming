section .data
    num dd 20
    nl db 10 
section .bss
    ascii resb 11
section .text 
    global main
main:
    mov eax, dword [num]
    add eax, '0'
    mov byte [ascii], al
    mov byte [ascii + 1], 0
    call print
print:
    mov rsi, ascii
    mov rax, 0x1
    mov rdi, 0x1
    mov rdx, 0x1    

    syscall

    mov rsi, nl
    mov rax, 0x1
    mov rdi, 0x1
    mov rdx, 0x1

    call end
end:
    mov eax, 60
    xor edi, edi

    syscall