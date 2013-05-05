section .data 
    hex_chars db "0123456789ABCDEF"; hexchar for pretty printing
section .text

global _start


_print_nibble:
    push rsi
    push rax
    push rdi
    push rdx
    mov rsi,hex_chars
    add rsi,rax
    mov rax,1
    mov rdi,1
    mov rdx,1
    syscall
    pop rdx
    pop rdi
    pop rax
    pop rsi
    ret

_print_al:
    push rbx
    mov bl,al
    shr al,4
    call _print_nibble
    mov al,bl
    and al, 0xf
    call _print_nibble
    pop rbx
    ret 

_print_rax:
    mov rcx,8

_next_byte: 
    push rax
    push rcx
    dec rcx
    shl rcx,3
    shr rax, cl
    and rax,0xFF
    call _print_al
    pop rcx
    pop rax
    dec rcx
    jnz _next_byte
    ret


_start:
  mov   rax, 0xb000b135b000b135  ; the value to print 
  call  _print_rax               ; print them to screen
  mov   rax,60 
  mov   rdi, 0                  
  syscall              
