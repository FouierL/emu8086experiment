
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

DATA      SEGMENT
          INP  DB 'PLEASE INPUT (a~z): ','$'       ;�����ַ���
          OUP  DB 'THE TRANSFORMATION(A~Z) IS:','$'
DATA      ENDS                               
CODE      SEGMENT
          ASSUME  CS:CODE,DS:DATA
MAIN      PROC FAR
START:    MOV AX,DATA
          MOV DS,AX   
          MOV DX,OFFSET INP                     ;��ʾ�ַ�������ʾ����
          MOV AH,9
          INT 21H 
          MOV AH,1                  ;DOS�жϵ��ã��Ӽ����ж�ȡһ���ַ�
          INT 21H 
          PUSH AX                                  ;AX��ջ
          PUSH DX
          MOV DL,0DH                               ;�жϵ��ã��س�
          MOV AH,2
          INT 21H                         
          MOV DL,0AH                               ;�жϵ��ã����� 
          MOV AH,2
          INT 21H                       
          MOV DX,OFFSET OUP            ;��ʾ�ַ����������ʾ
          MOV AH,9
          INT 21H
          POP DX                                   ;DX��ջ
          POP AX                                   ;AX��ջ
          SUB AL,32 ;AL��ȥ32��ʹ��дת��ΪСд
;��Сд֮���ASCII��ֵ���32
          MOV DL,AL                           ;DOS�ж���ʾ���
          MOV AH,2
          INT 21H
          MAIN   ENDP
CODE      ENDS
          END START


