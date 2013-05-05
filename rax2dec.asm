%macro sys_write 3
    mov eax,1
    mov rdi, %1
    mov rsi, %2
    mov rdx, %3
    syscall
%endmacro

section .data 
    hex_chars db "0123456789ABCDEF"; hexchar for pretty printing
    table db '0123456789'

section .bss
    output resb 256


section .text

global _start

_qw2a:
    lea r10 , [rsp-1]
    xor rcx,rcx
    mov r8,10
_L0:
    xor rdx,rdx
    div r8
    mov r9b,[table+rdx]
    mov [r10],r9b
    dec r10
    inc rcx
    test rax,rax
    jnz _L0

    lea rsi,[r10+1]
    cld
_L1:
    movsb
    cmp rsi,rsp
    jne _L1
    ret


_start:
  mov   rax, 0xb000b135b000b135  ; the value to print 
  mov rdi, output 
  call _qw2a 
  mov byte[rcx+output],0xa
  inc rcx
  sys_write 1,output,rcx
  mov   rax,60 
  mov   rdi, 0                  
  syscall              
