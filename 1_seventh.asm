
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

DATA      SEGMENT
          YI DB 44H,33H,22H,99H,00H 
          ER DB 44H,33H,22H,99H,00H      ;装载数据,必须有后面00H
          SUM DB 5 DUP()
          OUP  DB '99223344H + 99223344H= ','$'
        
DATA      ENDS                               
CODE      SEGMENT
          ASSUME  CS:CODE,DS:DATA
MAIN      PROC FAR
START:    MOV AX,DATA
          MOV DS,AX   
          MOV DX,OFFSET OUP              ;显示字符串
          MOV AH,9
          INT 21H 
          LEA BP,YI             ;在BP中装入YI的地址偏移量
          LEA SI,ER             ;在SI中装入ER的地址偏移量
          LEA DI,SUM             ;在DI中装入SUM的地址偏移量         
          MOV CX,05                      ;计数初值
          CLC                            ;进位位清零
NEXT:    MOV AL,[BP]                    ;将YI中的数据赋给AL
          MOV AH,[SI]                    ;将ER中的数据赋给BL
          ADC AL,AH                      ;YI和ER中的数据带进位的相加
          MOV [DI],AL                    ;将相加的结果保存在SUM中
          INC SI                         
          INC DI
          INC BP
          DEC CX                         
          JNZ NEXT             ;结果不为零，跳转到NEXT
;上面的程序已经将相加的结果存在了SUM中，下面的程序是将SUM中的结果转化为ASCII显示   
          MOV CH,05                      ;计数器初值
NEXT1:    MOV DH,[DI-1]                  ;将所得结果最高位赋给DH 
          MOV BX,02H 
NEXT2:    MOV CL,4                       
          ROL DH,CL                     ;将DH循环右移四位
          MOV AL,DH                    
          AND AL,0FH                    ;将AL高位清零
          CMP AL,09H                    ;与09H比较大小
          JBE NEXT3                     ;若小于，跳转至NEXT3
          ADD AL,07H        
NEXT3:    ADD AL,30H                    ;加30H
          MOV DL,AL
          MOV AH,2                      ;DOS中断显示
          INT 21H 
          DEC BX
          JNZ NEXT2  
          DEC DI
          DEC CH
          JNZ NEXT1                     ;循环显示SUM中的值
          MOV DL,'H'                    ;显示H
          MOV AH,2
          INT 21H   
          MAIN   ENDP
CODE      ENDS
          END START 



