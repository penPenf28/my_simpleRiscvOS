# 对start.S的解释

![image-20210903042002535](/home/xhw/.config/Typora/typora-user-images/image-20210903042002535.png)

MPP

mret会根据mpp中的值设置mret 之后进入用户程序后的hart的特权级别 ，11就是M态即machine态



MPIE

表示前一个的中断使用位，赋值1代表mret之后回到用户程序把中断打开



![image-20210903042445411](/home/xhw/.config/Typora/typora-user-images/image-20210903042445411.png)

![image-20210903042546647](/home/xhw/.config/Typora/typora-user-images/image-20210903042546647.png)

![image-20210903042608331](/home/xhw/.config/Typora/typora-user-images/image-20210903042608331.png)

