#include "platform.h"

    .equ    STACK_SIZE, 1024

    .global _start

    .text
_start:

    csrr    t0,mhartid  # 读取当前hard id
    mv      tp,t0       # tp register is thread pointer
    bnez    t0,park     # t0如果不是0，即hart不是0号hart则跳转到停止代码区，因为实现的是单核OS

    slli    t0,t0,10    
    la      sp,stacks + STACK_SIZE  #  将sp（堆栈指针）移到hart0 栈top的地方
    add     sp,sp,t0              
    j       start_kernel

park:
    wfi
    j park  # jump to park

stacks:
    .skip  STACK_SIZE * MAXNUM_CPU

    .end

    