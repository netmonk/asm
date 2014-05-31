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

    bindectable  db 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 6,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 2,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 4,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 8,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 6,5,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 2,1,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 4,2,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 8,4,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 6,9,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 2,9,1,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 4,8,3,6,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 8,6,7,2,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 6,3,5,5,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 2,7,0,1,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 4,4,1,2,6,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 8,8,2,4,2,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 6,7,5,8,4,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 2,5,1,7,9,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 4,0,3,4,9,1,4,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 8,0,6,8,8,3,8,0,0,0,0,0,0,0,0,0,0,0,0,0
	             db 6,1,2,7,7,7,6,1,0,0,0,0,0,0,0,0,0,0,0,0
	             db 2,3,4,4,5,5,3,3,0,0,0,0,0,0,0,0,0,0,0,0
	             db 4,6,8,8,0,1,7,6,0,0,0,0,0,0,0,0,0,0,0,0
	             db 8,2,7,7,1,2,4,3,1,0,0,0,0,0,0,0,0,0,0,0
	             db 6,5,4,5,3,4,8,6,2,0,0,0,0,0,0,0,0,0,0,0
	             db 2,1,9,0,7,8,6,3,5,0,0,0,0,0,0,0,0,0,0,0
	             db 4,2,8,1,4,7,3,7,0,1,0,0,0,0,0,0,0,0,0,0
	             db 8,4,6,3,8,4,7,4,1,2,0,0,0,0,0,0,0,0,0,0
	             db 6,9,2,7,6,9,4,9,2,4,0,0,0,0,0,0,0,0,0,0
	             db 2,9,5,4,3,9,9,8,5,8,0,0,0,0,0,0,0,0,0,0
	             db 4,8,1,9,6,8,9,7,1,7,1,0,0,0,0,0,0,0,0,0
	             db 8,6,3,8,3,7,9,5,3,4,3,0,0,0,0,0,0,0,0,0
	             db 6,3,7,6,7,4,9,1,7,8,6,0,0,0,0,0,0,0,0,0
	             db 2,7,4,3,5,9,8,3,4,7,3,1,0,0,0,0,0,0,0,0
	             db 4,4,9,6,0,9,7,7,8,4,7,2,0,0,0,0,0,0,0,0
	             db 8,8,8,3,1,8,5,5,7,9,4,5,0,0,0,0,0,0,0,0
	             db 6,7,7,7,2,6,1,1,5,9,9,0,1,0,0,0,0,0,0,0
	             db 2,5,5,5,5,2,3,2,0,9,9,1,2,0,0,0,0,0,0,0
	             db 4,0,1,1,1,5,6,4,0,8,9,3,4,0,0,0,0,0,0,0
	             db 8,0,2,2,2,0,3,9,0,6,9,7,8,0,0,0,0,0,0,0
	             db 6,1,4,4,4,0,6,8,1,2,9,5,7,1,0,0,0,0,0,0
	             db 2,3,8,8,8,0,2,7,3,4,8,1,5,3,0,0,0,0,0,0
	             db 4,6,6,7,7,1,4,4,7,8,6,3,0,7,0,0,0,0,0,0
	             db 8,2,3,5,5,3,8,8,4,7,3,7,0,4,1,0,0,0,0,0
	             db 6,5,6,0,1,7,6,7,9,4,7,4,1,8,2,0,0,0,0,0
	             db 2,1,3,1,2,4,3,5,9,9,4,9,2,6,5,0,0,0,0,0
	             db 4,2,6,2,4,8,6,0,9,9,9,8,5,2,1,1,0,0,0,0
	             db 8,4,2,5,8,6,3,1,8,9,9,7,1,5,2,2,0,0,0,0
	             db 6,9,4,0,7,3,7,2,6,9,9,5,3,0,5,4,0,0,0,0
	             db 2,9,9,0,4,7,4,5,2,9,9,1,7,0,0,9,0,0,0,0
	             db 4,8,9,1,8,4,9,0,5,8,9,3,4,1,0,8,1,0,0,0
	             db 8,6,9,3,6,9,8,1,0,7,9,7,8,2,0,6,3,0,0,0
	             db 6,3,9,7,2,9,7,3,0,4,9,5,7,5,0,2,7,0,0,0
	             db 2,7,8,5,5,8,5,7,0,8,8,1,5,1,1,4,4,1,0,0
	             db 4,4,7,1,1,7,1,5,1,6,7,3,0,3,2,8,8,2,0,0
	             db 8,8,4,3,2,4,3,0,3,2,5,7,0,6,4,6,7,5,0,0
	             db 6,7,9,6,4,8,6,0,6,4,0,5,1,2,9,2,5,1,1,0
	             db 2,5,9,3,9,6,3,1,2,9,0,0,3,4,8,5,0,3,2,0
	             db 4,0,9,7,8,3,7,2,4,8,1,0,6,8,6,1,1,6,4,0
	             db 8,0,8,5,7,7,4,5,8,6,3,0,2,7,3,3,2,2,9,0

    result db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0




section .text
printbin2dec:
        xor rcx, rcx; initialising counter to 0 going to 63 (0..63=64 bits)
        xor r10b,r10b; carry value
        xor rbx,rbx; initialising rbx which is the offset of byte in bindectable
        xor r8b, r8b; initialising r8b for working
        xor r9b, r9b; initialising r9b for working
begin: 	
        xor rdx,rdx; setting rdx to 0 (counter to travel into result)
	    cmp rcx, 64 ; if general counter=64 then finish the whole work
	    je end; jump to the end for return
	    shr rax,1; shift to right one digit
	    jnc noop; if the carry flag is equal 0 nothing to do 
addbig: ; else we have to add content of the related line of bindectable to result
        mov r8b,[result+rdx]; loading into r8b the byte of result we manipulate
	    mov r9b,[bindectable+rbx]; loading into r9b the first byte of the line of bindectable
	    add r8b,r9b; add the value to r8b
	    add r8b,r10b; add the carry to r8b
	    cmp r8b,10 ; test is result >10
	    jb nocarry; if not 
	    mov r10b,1; set the carry
	    sub r8b,10; subtract 10 to value to get the last digit 
	    mov [result+rdx],r8b ; storing it to the good place in result
	    jmp continue; jump to end of loop
nocarry: 
	    mov r10b,0 ;setting back the carry value to zero
        mov [result+rdx], r8b; storing the byte into result
        jmp continue; jump to continue
continue: ; ending part of the loop
	    inc rdx; increasing the offset of result
	    inc rbx; increasing the offset of bindectable rbx
	    cmp rdx,20; compare it to 20(is it end of result line)
	    je begin; if so , jump to begin for processing next general digit
	    jmp addbig; else jump to process the next byte in the line 
noop: 
	    inc rcx; in case the carry flag is equal 0 nothing to do, so
	    add rbx, 20; increase the general counter, and the offset of bindectable
	    jmp begin; and reentering into the loop
end:
	    ret		


;; loop1 is used to transform the content of result into ascii
;; if a byte has the "1" value, the ascii code is 48+1=49
;; so we just need to add 48 to all byte of result and adding a \n at the end 
;; total size is 21 chars. 
loop1:
    xor rcx, rcx
loop4:
    add [result+rcx], byte 48
    inc rcx
    cmp rcx, 20
    jnae loop4
    mov byte[result+rcx],0xa
    inc rcx
    sys_write 1, result,rcx
    ret 

;; Init result is used to reinitiate result to '0' byte value
;; just a little loop of 20 
initresult:
    xor rcx,rcx
loop3:
    mov byte[result+rcx],0x0
    inc rcx
    cmp rcx,20
    jnae loop3
    ret 

;; start point of the program
;; 
global _start 
_start:
   	    sys_write 1,Stmsg,StmsgLen; writing starting msg 
        xor rax, rax
        xor r15, r15
        inc r15 
        call printbin2dec
loop2:
        mov rax, r15
        call printbin2dec
        call loop1
        call initresult
        shl r15,1
        inc r15
        jc Done
        jmp loop2
Done:
    	mov rax,60 ; load the 60 (exit) syscall value into rax
    	mov rdi,0 ; load into rdi the return value of exit code
    	syscall; call the kernel syscall
