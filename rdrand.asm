; Defining syswrite macro
%macro sys_write 3
    mov rdi, %1
    mov rsi, %2
    mov rdx, %3
    mov eax,1
    syscall
%endmacro

section .data 
    Stmsg: db "Starting computation",10  ;  Starting msg 
    StmsgLen equ $-Stmsg   ; length of Stmsg 

    bindectable:
	dq 10
	dq 100
	dq 1000
	dq 10000
	dq 100000
	dq 1000000
	dq 10000000
	dq 100000000
	dq 1000000000
	dq 10000000000
	dq 100000000000
	dq 1000000000000
	dq 10000000000000
	dq 100000000000000
	dq 1000000000000000
	dq 10000000000000000
	dq 100000000000000000
	dq 1000000000000000000
	dq 10000000000000000000

    result db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

section .text
printbin2dec:
        mov esi, 18  ; 19 powers of 10
	mov edi, 4   ; optimize for < 1000000
	cmp rax, [bindectable+rdi*8+8]
	cmovb esi, edi
	xor edx, edx ; output index
.nextdigit:
	mov cl, -1
	mov rdi, [bindectable+rsi*8]
.loop:
	add cl, 1
	sub rax, rdi
	jnc .loop
	add rax, rdi ; undo last step
	mov [result+rdx], cl
; if cl==0 && dl==0 we have a leading zero, skip it
	or cl, dl
	setnz cl
	add dl, cl
	sub esi, 1
	jnc .nextdigit
	mov byte [result+rdx], al
	lea rax, [rdx+1] ; return length
	ret		

global _start 
_start:
        sys_write 1,Stmsg,StmsgLen; writing starting msg 
        xor rax, rax
        ;inc rax
        ;mov rax, 18446744073709551615
rd:     
        rdrand rax
        jc compute
        xor rax, rax 
        jmp rd
compute:
        call printbin2dec
	xor rcx, rcx
loop1:
	add [result+rcx], byte 48
	inc rcx
	cmp rcx, 20
	jnae loop1
	;mov byte[result+rax],0xa
	;inc rax
	sys_write 1, result,rax
        jmp rd
Done:
    	mov rax,60 ; load the 60 (exit) syscall value into rax
    	mov rdi,0 ; load into rdi the return value of exit code
    	syscall; call the kernel syscall
