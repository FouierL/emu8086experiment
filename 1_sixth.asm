
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

DATA      SEGMENT
          INP  DB 'PLEASE INPUT (a~z): ','$'       ;设置字符串
          OUP  DB 'THE TRANSFORMATION(A~Z) IS:','$'
DATA      ENDS                               
CODE      SEGMENT
          ASSUME  CS:CODE,DS:DATA
MAIN      PROC FAR
START:    MOV AX,DATA
          MOV DS,AX   
          MOV DX,OFFSET INP                     ;显示字符串，提示输入
          MOV AH,9
          INT 21H 
          MOV AH,1                  ;DOS中断调用，从键盘中读取一个字符
          INT 21H 
          PUSH AX                                  ;AX入栈
          PUSH DX
          MOV DL,0DH                               ;中断调用，回车
          MOV AH,2
          INT 21H                         
          MOV DL,0AH                               ;中断调用，换行 
          MOV AH,2
          INT 21H                       
          MOV DX,OFFSET OUP            ;显示字符串，输出提示
          MOV AH,9
          INT 21H
          POP DX                                   ;DX出栈
          POP AX                                   ;AX出栈
          SUB AL,32 ;AL减去32，使大写转化为小写
;大小写之间的ASCII码值相差32
          MOV DL,AL                           ;DOS中断显示结果
          MOV AH,2
          INT 21H
          MAIN   ENDP
CODE      ENDS
          END START


