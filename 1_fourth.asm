
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

DATA  SEGMENT 
    OUP  DB  'THE ASCII OF 7963 IS:','$'
    A1  DB  07H,09H,06H,03H
DATA  ENDS
CODE  SEGMENT
    ASSUME  CS:CODE,DS:DATA
START:
    MOV     AX,DATA
    MOV     DS,AX
    MOV     DX,OFFSET OUP
    MOV     AH,09H
    INT     21H
    MOV     CL,4
    MOV     SI,0
NEXT:
    MOV     AL,A1[SI]   ;将A1的第SI个数据传给AL
    MOV     BL,AL
    OR     AL,30H        ;加30转换为ASCII码值
    SHR     AL,4
    AND     AL,0FH       ;将右移后的高位清零
    ADD     AL,30H       ;因为ASCII码与值之间相差30
    MOV     DL,AL
    MOV     AH,2         ;输出对应的ASCII码
    INT     21H 
    MOV     AL,BL
    AND     AL,0FH
    ADD     AL,30H
    MOV     DL,AL
    MOV     AH,02H
    INT     21H
    MOV     DL,' '
    MOV     AH,02H
    INT     21H
    INC     SI
    LOOP     NEXT
EXIT:
    MOV     AH,4CH
    INT     21H
CODE     ENDS
   END     START



