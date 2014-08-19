# n! means n × (n − 1) × ... × 3 × 2 × 1                                                                
# Find the sum of the digits in the number 100! 

.section .data
fac:
        .fill 256, 1, 0
out:
        .asciz "-> %d\n"
N:
        .int 100
        
.section .text
.globl _start
.extern printf
_start:
        xorq %rdx, %rdx
        movb $1, (fac)
        movl $2, %edi
        movl $1, %r8d # numebr of digits

main_loop:
        xorl %r9d, %r9d
        xorl %ebx, %ebx 
        movl %r8d, %ecx
        
loop1:
        movzbl fac(, %ebx, 1), %eax
        mull %edi
        addl %r9d, %eax
        movl $10, %r10d
        divl %r10d
        movb %dl, fac(, %ebx, 1)
        movl %eax, %r9d
        xorl %edx, %edx
        addl $1, %ebx
        loop loop1

1:
        cmpl $0, %r9d
        je 2f
        movl %r9d, %eax
        xorl %edx, %edx
        movl $10, %r10d
        divl %r10d
        movb %dl, fac(, %ebx, 1) 
        movl %eax, %r9d
        addl $1, %r8d
        addl $1, %ebx
        jmp 1b
2:
        addl $1, %edi
        cmpl N, %edi
        jle main_loop

        xorq %r9, %r9
        xorl %ecx, %ecx
sum:
        movzbl fac(, %ecx, 1), %ebx 
        addl %ebx, %r9d
        addl $1, %ecx
        cmpl %r8d, %ecx
        jl sum
        
        movq $out, %rdi
        movq %r9, %rsi
        pushq %rcx
        pushq %r8
        call printf
        popq %r8
        popq %rcx
        
        movq $0x3c, %rax
        movq $0, %rdi
        syscall
        