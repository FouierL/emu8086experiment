
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

DATA      SEGMENT
          YI DB 44H,33H,22H,99H,00H 
          ER DB 44H,33H,22H,99H,00H      ;װ������,�����к���00H
          SUM DB 5 DUP()
          OUP  DB '99223344H + 99223344H= ','$'
        
DATA      ENDS                               
CODE      SEGMENT
          ASSUME  CS:CODE,DS:DATA
MAIN      PROC FAR
START:    MOV AX,DATA
          MOV DS,AX   
          MOV DX,OFFSET OUP              ;��ʾ�ַ���
          MOV AH,9
          INT 21H 
          LEA BP,YI             ;��BP��װ��YI�ĵ�ַƫ����
          LEA SI,ER             ;��SI��װ��ER�ĵ�ַƫ����
          LEA DI,SUM             ;��DI��װ��SUM�ĵ�ַƫ����         
          MOV CX,05                      ;������ֵ
          CLC                            ;��λλ����
NEXT:    MOV AL,[BP]                    ;��YI�е����ݸ���AL
          MOV AH,[SI]                    ;��ER�е����ݸ���BL
          ADC AL,AH                      ;YI��ER�е����ݴ���λ�����
          MOV [DI],AL                    ;����ӵĽ��������SUM��
          INC SI                         
          INC DI
          INC BP
          DEC CX                         
          JNZ NEXT             ;�����Ϊ�㣬��ת��NEXT
;����ĳ����Ѿ�����ӵĽ��������SUM�У�����ĳ����ǽ�SUM�еĽ��ת��ΪASCII��ʾ   
          MOV CH,05                      ;��������ֵ
NEXT1:    MOV DH,[DI-1]                  ;�����ý�����λ����DH 
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
          DEC DI
          DEC CH
          JNZ NEXT1                     ;ѭ����ʾSUM�е�ֵ
          MOV DL,'H'                    ;��ʾH
          MOV AH,2
          INT 21H   
          MAIN   ENDP
CODE      ENDS
          END START 



