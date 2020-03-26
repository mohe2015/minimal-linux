.global _start
_start:
    mov $1, %rax
    mov $1, %rdi
    mov $message, %rsi
    mov $message_len, %rdx
    syscall
    jmp .
    message: .ascii "FOOBAR FOOBAR FOOBAR FOOBAR FOOBAR FOOBAR FOOBAR\n"
    .equ message_len, . - message
