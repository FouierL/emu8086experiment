
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
        MOV     DX,OFFSET MES               ;���ַ���ƫ����д��DX
        MOV     AH,09H
        INT     21H          
        MOV     AX,BNUM                     ;��0500H����AX��
        LEA     BX,DNUM                                ;ȡDNUM��ƫ����
        MOV     DL,0  
;����1000�ĸ���
COUNT1:   
        SUB     AX,03E8H                                    ;AX-1000
        JC      NEXT1                     ;������������CF=1���н�λ��תNEXT1
        INC     DL                                          ;DL+1
        JMP     COUNT1                                      ;��תAGAIN1
NEXT1:    
        ADD     AX,03E8H                                    ;AX+1000
        MOV     [BX],DL                   ;��DL(��ǧλ��������DNUM��
        INC     BX                                          ;BX+1
        MOV     DL,0                                        ;DL����
;����100����
COUNT2:   
        SUB     AX,0064H           ;AX-100
        JC      NEXT2
        INC     DL
        JMP     COUNT2
NEXT2:    
        ADD     AX,0064H
        MOV     [BX],DL            ;��DL(����λ��������DNUM��
        INC     BX
        MOV     DL,0 
;����10����          
COUNT3:   
        SUB     AX,000AH           ;AX-10
        JC      NEXT3
        INC     DL
        JMP     COUNT3
NEXT3:    
        ADD     AX,000AH
        MOV     [BX],DL            ;��DL(ʮλ��)����DNUM��
        INC      BX               
        MOV     [BX],AL            ;�����λ��
;�������ĳ����ǽ���ֵת��ΪASCII������Ļ����ʾ          
        MOV     CX,4
        LEA      SI,DNUM          ;ȡDNUM�ĵ�ַƫ����
NEXT4: 
    MOV     AL,[SI] ;��DNUM������ĸ�����ֵת��ΪASCII�룻
;����Ļ�������ʾ
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




