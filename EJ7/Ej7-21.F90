CHARACTER(LEN=80) linea
CHARACTER(LEN=20) nombre, direcc
CHARACTER(LEN=10) telef, nif, tipo, fax, cif
CHARACTER(LEN=30) email

   OPEN (12, FILE='EJ7-21.dat')
10 READ (12,'(A80)') linea
   SELECT CASE (linea(1:1))
     CASE ('1')
       READ(linea,'(1X,2A20,3A10)') nombre, direcc, telef, nif, tipo
!      CALL cliente
     CASE ('2')
       READ(linea,'(1X,A15,A20,3A10)') nombre, direcc, telef, fax, cif
!      CALL empresa
     CASE ('3')
       READ(linea,'(1X,A30)') email
!      CALL correo
     CASE ('0')
       STOP ' Fin del programa'
   ENDSELECT
   GOTO 10
END