#include"os.h"

extern void trap_vector(void);

void trap_init(){
    /*
	 * set the trap-vector base-address for machine-mode
	 */
	w_mtvec((reg_t)trap_vector);
}

reg_t trap_handler(reg_t epc,reg_t cause){
    reg_t return_pc = epc;
    reg_t cause_code = cause;
    if(cause & 0x80000000){
        switch (cause_code)
        {
        case 3:
            uart_puts("software interruption!\n");
            break;
        case 7:
            uart_puts("timer interruption!\n");
            break;
        case 11:
            uart_puts("external interruption!\n");
            break;
        
        
        default:
            uart_puts("unknown async exception!\n");
            break;
        }
    }
    else{
        printf("Sync exceptions!,code =%d\n",cause_code);
        panic("OOPS! What can i do!");

    }
    return return_pc;
}


void trap_test(){

    *(int *)0x00000000=100;

    uart_puts("Yeah! I'm return back from trap!\n");

}