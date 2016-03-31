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
; nasm -f elf64 -g -F stabs -o fibo.o fibo.asm
; ld -o fibo fibo.o
;./fibo 
; 
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
    fmt: db "%ld", 10,0
    a: dq 0; first step equal 1
    b: dq 1; second step equal 1
    table db '0123456789'

extern printf

global main 
main: 
    nop
    sys_write 1,Stmsg,StmsgLen; writing starting msg 

; initialisation of first two steps. 
    xor r14,r14 ; r14 = 0
    xor r12,r12 ; r12 = 0
    mov r14,[a] ; r14 =1
    mov r12,[b] ; r12 =1


Fibo: 
    add r14,r12 ; r14=r14+r12
    jc Done; if overflow (CF=1) then jump to end
    ;mov rax, r14 ; loading value of r14 into rax
    ;mov rdi, output; loading address of output to rdi
    ;call _qw2a ; calling the reg2dec function
    push rbp 
    mov rsi,r14
    mov rdi,fmt
    xor rax,rax
    call printf
    add r12,r14; r12=r14+r12 (r14 already have the new value from last add)
    jc Done; if overflow (CF=1) then jump to end
    push rbp	
    mov rsi,r12
    mov rdi,fmt
    xor rax,rax
    call printf
    jmp Fibo;
Done: 
    sys_write 1,Edmsg,EdmsgLen; printing end msg
    mov rax,60 ; load the 60 (exit) syscall value into rax
    mov rdi,0 ; load into rdi the return value of exit code
    syscall; call the kernel syscall 
