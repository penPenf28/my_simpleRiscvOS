#include "platform.h"

    .equ    STACK_SIZE, 1024

    .global _start

    .text
_start:

    csrr    t0,mhartid  # 读取当前hard id
    mv      tp,t0       # tp register is thread pointer
    bnez    t0,park     # t0如果不是0，即hart不是0号hart则跳转到停止代码区，因为实现的是单核OS


    # Set all bytes in the BSS section to zero.
	la	a0, _bss_start
	la	a1, _bss_end
	bgeu	a0, a1, 2f        

1:
	sw	zero, (a0)
	addi	a0, a0, 4
	bltu	a0, a1, 1b

2:
	# Setup stacks, the stack grows from bottom to top, so we put the
	# stack pointer to the very end of the stack range.
	slli	t0, t0, 10		# shift left the hart id by 1024
	la	sp, stacks + STACK_SIZE	# set the initial stack pointer
					# to the end of the first stack space
	add	sp, sp, t0		# move the current hart stack pointer
					# to its place in the stack space


    j       start_kernel

park:
    wfi
    j park  # jump to park

stacks:
    .skip  STACK_SIZE * MAXNUM_CPU

    .end

    