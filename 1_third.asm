
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

DATA      SEGMENT
          BNUM DW 0500H
          DNUM DB 4 DUP()         
          MES  DB 'THE BCD OF '500H' IS: ','$'
DATA      ENDS
CODE      SEGMENT
           ASSUME  CS:CODE,DS:DATA
START:
        MOV     AX,DATA
        MOV     DS,AX      
        MOV     DX,OFFSET MES               ;将字符串偏移量写入DX
        MOV     AH,09H
        INT     21H          
        MOV     AX,BNUM                     ;将0500H存入AX中
        LEA     BX,DNUM                                ;取DNUM的偏移量
        MOV     DL,0  
;计算1000的个数
COUNT1:   
        SUB     AX,03E8H                                    ;AX-1000
        JC      NEXT1                     ;不够减，即若CF=1，有借位，转NEXT1
        INC     DL                                          ;DL+1
        JMP     COUNT1                                      ;跳转AGAIN1
NEXT1:    
        ADD     AX,03E8H                                    ;AX+1000
        MOV     [BX],DL                   ;将DL(即千位数）存入DNUM中
        INC     BX                                          ;BX+1
        MOV     DL,0                                        ;DL清零
;计算100个数
COUNT2:   
        SUB     AX,0064H           ;AX-100
        JC      NEXT2
        INC     DL
        JMP     COUNT2
NEXT2:    
        ADD     AX,0064H
        MOV     [BX],DL            ;将DL(即百位数）存入DNUM中
        INC     BX
        MOV     DL,0 
;计算10个数          
COUNT3:   
        SUB     AX,000AH           ;AX-10
        JC      NEXT3
        INC     DL
        JMP     COUNT3
NEXT3:    
        ADD     AX,000AH
        MOV     [BX],DL            ;将DL(十位数)存入DNUM中
        INC      BX               
        MOV     [BX],AL            ;计算个位数
;接下来的程序是将数值转化为ASCII并在屏幕上显示          
        MOV     CX,4
        LEA      SI,DNUM          ;取DNUM的地址偏移量
NEXT4: 
    MOV     AL,[SI] ;将DNUM中所存的各个数值转换为ASCII码；
;在屏幕上输出显示
        CMP      AL,09H
        JBE       NEXT5
        ADD      AL,07H        
NEXT5:
     ADD      AL,30H 
        MOV      DL,AL
        MOV      AH,2
        INT       21H 
        INC       SI
        DEC      CX 
        JNZ       NEXT4   
CODE      ENDS
          END    START




