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

; how to compile :  
; nasm -f elf64 -g -F stabs -o fibosimple.o fibosimple.asm
; ld -o fibosimple fibosimple.o
;./fibosimple 
;
; This version is a very basic version only dealing with arithmetical operation
; of register.
; To view the content of R8 and R9 you must use a debugger as gdb or kdbg.
; 
; Courtesy of Netmonk, netmonk at netmonk dot org 
; http://www.netmonk.org



section .data
section .bss
section .text
global _start 
_start: 
    mov r8,1 ; r8=1
    mov r9,1 ; r9=1
boucle: 
    add r8,r9 ; r8=r8+r9
    jc fin;Jump to fin is overflow (CF=1) 
    add r9,r8; r9=r8+r9
    jc fin; Jump to fin is overflow (CF=1) 
    jmp boucle; Jump to boucle to process another iteration 
fin: 
    mov rax,60 ; load Syscall number to rax register 
    mov rdi,0 ; load into rdi the return value of exit 
    syscall; Call the syscall command
