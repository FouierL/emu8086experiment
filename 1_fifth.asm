
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

DATA     SEGMENT
          YI  DB 100 DUP(88H) 
          ER  DB 100 DUP(00H)                           ;��������
          MES  DB 'THE NUMBER OF COUNTER IS: ','$'
DATA      ENDS
CODE      SEGMENT
          ASSUME  CS:CODE,DS:DATA
MAIN      PROC FAR
START:    MOV AX,DATA
          MOV DS,AX 
          MOV CL,100                     ;��������ֵ
          MOV CH,00H                     ;ת�ƴ���ͳ�ƣ���ֵ
          LEA SI,YI                      ;���ڴ��1��ƫ������SI
          LEA DI,ER                      ;���ڴ��2��ƫ������DI
NEXT:     MOV AL,[SI]
          MOV [DI],AL                    ;��YI�е����ݸ��Ƶ�ER��
          INC SI
          INC DI
          INC CH
          MOV DX,OFFSET MES              ;��ʾ�ַ���
          MOV AH,9
          INT 21H  
          CALL COUNT                     ;�����ӳ���
          DEC CL                         ;������1
          JNZ NEXT                       ;������Ϊ�㣬��תִ��
          HLT 
          MAIN   ENDP                    ;���������
;�������ӳ���ʵ����Ļ��ʾת�ƴ�������
COUNT     PROC NEAR                      ;�����ӳ�������
          PUSH CX                        ;CX��ջ
          MOV DH,CH
          MOV BX,02H 
NEXT2:    MOV CL,4                       
          ROL DH,CL                     ;��DHѭ��������λ
          MOV AL,DH                    
          AND AL,0FH                    ;��AL��λ����
          CMP AL,09H                    ;��09H�Ƚϴ�С
          JBE NEXT3                     ;��С�ڣ���ת��NEXT3
          ADD AL,07H        
NEXT3:    ADD AL,30H                    ;��30H
          MOV DL,AL
          MOV AH,2                      ;DOS�ж���ʾ
          INT 21H 
          DEC BX
          JNZ NEXT2  
          MOV DL,'H'                     ;��ʾH
          MOV AH,2
          INT 21H 
          MOV DL,0AH                     ;�س�
          MOV AH,2
          INT 21H  
          MOV DL,0DH                     ;����
          MOV AH,2
          INT 21H  
          POP CX                         ;CX��ջ
          RET
COUNT     ENDP
;�ӳ������
CODE      ENDS
          END  START




