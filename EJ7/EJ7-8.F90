PROGRAM basedatos
IMPLICIT NONE

CHARACTER(LEN=20) nombre
INTEGER dni, edad
INTEGER numreg, regmal, ios
REAL peso, altura

OPEN (11, FILE='EJ7-8.dat')
OPEN (12, FILE='EJ7-8.sal')

numreg = 0
10 CONTINUE
numreg = numreg + 1
regmal = 0 ! si regmal=1 el registro tendra errores

READ (11,8000,IOSTAT=ios,ERR=20,END=30) nombre, dni, edad, peso, altura
8000 FORMAT (A20,I10,I2,2F5.0)

IF (edad<=0 .OR. peso<=0 .OR. peso>130 .OR.   &
    altura<=0 .OR. altura>220) regmal = 1

20 IF (ios/=0 .OR. regmal==1) THEN    ! registro con error
     WRITE (12,9010) numreg
     9010 FORMAT (' *** El registro',I6,' tiene errores ***')
   ELSE
     WRITE (12,8000) nombre, dni, edad, peso, altura
   ENDIF
GOTO 10

30 STOP
ENDPROGRAM basedatos