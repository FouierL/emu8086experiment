
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

DATA  SEGMENT
      SZ DB 80H,03H,5AH,0FFH,97H,64H,0BBH,7FH,0FH,0D8H;�������
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
      MOV     SI ,OFFSET  SZ        ;�����ƫ�Ƶ�ַ����SI
      MOV     CX,10                 ;�������ĳ��ȸ�CX
      MOV     DH,80H                ;������ĵ�һ����д��DH
NEXT:    
      MOV     BL,[SI]               ;������ĵ�һ����д��BL
      CMP     DH,BL                 ;�Ƚ�DH��BL�����ĵ�У
      JAE     NEXT1    ;���DH�е�������BL�У�����ת��NEXT1
      MOV     DH,BL ;���DH�е���С��BL�У���BL�е�������DH
NEXT1:
      INC     SI                    ;ƫ�Ƶ�ַ��1
      LOOP    NEXT;ѭ����CX�Լ�һֱ��0��DH�д���������ֵ
      MOV     BX,02H 
NEXT2:    
      MOV     CL,4                       
      ROL     DH,CL                     ;��DHѭ��������λ
      MOV     AL,DH                    
      AND     AL,0FH    ;��AL��λ���㣬һλһλ����ASCII��ת��
      CMP     AL,09H                    ;��09H�Ƚϴ�С
      JBE     NEXT3    ;��С�ڣ���ת��NEXT3��֤����ֵ��0-9֮��
      ADD     AL,07H ;�����ڣ���֤��Ϊ��ĸ����Ϊ��ĸ�����ֵ�ASCII�����7������Ҫ����7
NEXT3:    
      ADD     AL,30H                 ;��Ϊת��ΪASCII��Ҫ��30H
      MOV     DL,AL
      MOV     AH,2                      ;DOS�ж���ʾ
      INT     21H 
      DEC     BX
      JNZ     NEXT2  
      MOV     DL,'H'
      MOV     AH,2
      INT     21H 
CODE  ENDS
END   START




