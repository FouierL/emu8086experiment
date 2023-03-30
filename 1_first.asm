
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

DATA  SEGMENT
      SZ DB 80H,03H,5AH,0FFH,97H,64H,0BBH,7FH,0FH,0D8H;存进数组
      SHOW DB 'THE MAX IS: ','$'
DATA  ENDS
CODE  SEGMENT
ASSUME  CS:CODE,DS:DATA 
START:  
      MOV     AX,DATA      
      MOV     DS,AX                     
      MOV     DX,OFFSET SHOW        
      MOV     AH,09H
      INT     21H                   
      MOV     SI ,OFFSET  SZ        ;数组的偏移地址赋给SI
      MOV     CX,10                 ;存进数组的长度给CX
      MOV     DH,80H                ;将数组的第一个数写进DH
NEXT:    
      MOV     BL,[SI]               ;将数组的第一个数写进BL
      CMP     DH,BL                 ;比较DH和BL中数的到校
      JAE     NEXT1    ;如果DH中的数大于BL中，将跳转到NEXT1
      MOV     DH,BL ;如果DH中的数小于BL中，将BL中的数赋给DH
NEXT1:
      INC     SI                    ;偏移地址加1
      LOOP    NEXT;循环，CX自减一直到0，DH中存数组的最大值
      MOV     BX,02H 
NEXT2:    
      MOV     CL,4                       
      ROL     DH,CL                     ;将DH循环右移四位
      MOV     AL,DH                    
      AND     AL,0FH    ;将AL高位清零，一位一位进行ASCII码转换
      CMP     AL,09H                    ;与09H比较大小
      JBE     NEXT3    ;若小于，跳转至NEXT3，证明数值在0-9之间
      ADD     AL,07H ;若大于，则证明为字母，因为字母与数字的ASCII码相差7，所以要加上7
NEXT3:    
      ADD     AL,30H                 ;因为转换为ASCII码要加30H
      MOV     DL,AL
      MOV     AH,2                      ;DOS中断显示
      INT     21H 
      DEC     BX
      JNZ     NEXT2  
      MOV     DL,'H'
      MOV     AH,2
      INT     21H 
CODE  ENDS
END   START




