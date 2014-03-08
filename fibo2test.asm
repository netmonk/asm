; #############################################################################
; #####################  licensing stuff : nBSDL ##############################
; Copyright (c) 2013, netmonk.org 
; All rights reserved.
; Redistribution and use in source and binary forms, with or without 
; modification, are permitted provided that the following conditions are met:
;
; Redistributions of source code must retain the above copyright notice, this 
; list of conditions and the following disclaimer.
; Redistributions in binary form must reproduce the above copyright notice, 
; this list of conditions and the following disclaimer in the documentation 
; and/or other materials provided with the distribution.
;
; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
; ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
; CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF 
; THE POSSIBILITY OF SUCH DAMAGE.
; #############################################################################

; Im starting to play with nasm on 64bits linux
; this is just a working code which will compute the 
; 100 firsts round of fibonaci starting with (1,1)
; The main difficulties is not to compute the number
; its about displaying them 
; I find an elegant way there : 
; http://cogsandlevers.blogspot.fr/2013/01/printing-registers-value-in-hex.html
; also a dude (tefter) from #asm@freenode 
; provided a nice version to print in decimal way !
; 
; this code is for linux x86_64 only: 
; how to compile :  
; nasm -f elf64 -g -F stabs -o fibo2test.o fibo2test.asm
; ld -o fibo2test fibo2test.o
;./fibo 
; 
; This version uses the mmx instructions, instead of standard registers.
; Courtesy of Netmonk, netmonk at netmonk dot org 
; http://www.netmonk.org



; Defining syswrite macro
%macro sys_write 3
    mov eax,1
    mov rdi, %1
    mov rsi, %2
    mov rdx, %3
    syscall
%endmacro


section .data
    Stmsg: db "Starting computation",10  ;  Starting msg 
    StmsgLen equ $-Stmsg   ; length of Stmsg 
    Edmsg: db "Ending computation",10   ; Ending msg
    EdmsgLen equ $-Edmsg ; length of Edmsg
    a: dq 1; first step equal 1
    b: dq 1; second step equal 1
    table db '0123456789'

section .bss
    output resb 256 

section .text
; the special code to transform the content of rax into integer
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
; end of this code

global _start 
_start: 
    nop
    sys_write 1,Stmsg,StmsgLen; writing starting msg 

; initialisation of first two steps. 
    ;xor r14,r14 ; r14 = 0
    pxor mm1,mm1 ; r14 = 0
    pxor mm2,mm2 ; r12 = 0
    movq mm1,[a] ; r14 =1
    movq mm2,[b] ; r12 =1
    xor r13,r13 ; initialising counter


Fibo: 
    paddq mm1,mm2 ; r14=r14+r12
    movq rax, mm1 ; loading value of r14 into rax
    mov rdi, output; loading address of output to rdi
    call _qw2a ; calling the reg2dec function
    mov byte[rcx+output],0xa; adding \n at the end of buffer
    inc rcx ; incrementing the size of the value to consider the \n
    sys_write 1,output,rcx; call the sys_write macro
; almost same as above we compute two numbers for each round in loop
    paddq mm2,mm1; r12=r14+r12 (r14 already have the new value from last add)
    movq rax,mm2 ; loading value of r12 to rax
    mov rdi, output ; loading buffer address into rdi 
    call _qw2a; calling the reg2dec
    mov byte[rcx+output],0xa; adding \n for pretty printing
    inc rcx; incrementing size value
    sys_write 1,output,rcx; printing

    inc r13 ; incrementing general counter
    cmp r13,45; compare is < to 45
    jna Fibo; if so then loop to Fibo

    sys_write 1,Edmsg,EdmsgLen; printing end msg
Done: 
    mov rax,60 ; load the 60 (exit) syscall value into rax
    mov rdi,0 ; load into rdi the return value of exit code
    syscall; call the kernel syscall 
