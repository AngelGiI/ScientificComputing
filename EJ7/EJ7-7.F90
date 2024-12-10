10 WRITE (*,'(A)',ADVANCE='NO') ' Numero de casos n = '
READ (*, '(I4)', ERR=10, END=10) n
20 WRITE (*,'(A)',ADVANCE='NO') ' Numero de variables m = '
READ (*, '(I4)', ERR=20, END=20) m
30 WRITE (*,9000)
9000 FORMAT (/T5,'Analisis a realizar:'      &
             /T10,'1: Regresion multilineal' &
             /T10,'2: Correspondencias'      &
             /T10,'3: Analisis de la varianza')
WRITE (*,'(T15,A)',ADVANCE='NO') 'opcion = '
READ (*, *, ERR=30, END=30) iopc
IF (iopc<1 .OR. iopc>3) GOTO 30
END
