
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

DATA     SEGMENT
          YI  DB 100 DUP(88H) 
          ER  DB 100 DUP(00H)                           ;定义数组
          MES  DB 'THE NUMBER OF COUNTER IS: ','$'
DATA      ENDS
CODE      SEGMENT
          ASSUME  CS:CODE,DS:DATA
MAIN      PROC FAR
START:    MOV AX,DATA
          MOV DS,AX 
          MOV CL,100                     ;计数器初值
          MOV CH,00H                     ;转移次数统计，初值
          LEA SI,YI                      ;将内存块1的偏移量给SI
          LEA DI,ER                      ;将内存块2的偏移量给DI
NEXT:     MOV AL,[SI]
          MOV [DI],AL                    ;将YI中的数据复制到ER中
          INC SI
          INC DI
          INC CH
          MOV DX,OFFSET MES              ;显示字符串
          MOV AH,9
          INT 21H  
          CALL COUNT                     ;调用子程序
          DEC CL                         ;计数减1
          JNZ NEXT                       ;计数不为零，跳转执行
          HLT 
          MAIN   ENDP                    ;主程序结束
;下面是子程序，实现屏幕显示转移次数功能
COUNT     PROC NEAR                      ;定义子程序属性
          PUSH CX                        ;CX进栈
          MOV DH,CH
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
          MOV DL,'H'                     ;显示H
          MOV AH,2
          INT 21H 
          MOV DL,0AH                     ;回车
          MOV AH,2
          INT 21H  
          MOV DL,0DH                     ;换行
          MOV AH,2
          INT 21H  
          POP CX                         ;CX出栈
          RET
COUNT     ENDP
;子程序结束
CODE      ENDS
          END  START




