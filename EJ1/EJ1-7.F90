PROGRAM sistemas_de_dos_ecuaciones
REAL a(2,2), b(2), x(2), det
CHARACTER(LEN=20) filedat, filesol     
INTEGER i

! Lectura de los nombres de los ficheros de datos y resultados

WRITE (*,'(A)') ' fichero de datos = '
READ (*,'(A)') filedat
OPEN (11, FILE=filedat)
WRITE (*,'(A)') ' fichero de resultados = '
READ (*,'(A)') filesol
OPEN (12, FILE=filesol)

! Lectura de los datos

READ (11,*) (a(1,j),j=1,2), b(1)
READ (11,*) (a(2,j),j=1,2), b(2)

! Solucion del sistema

det = a(1,1)*a(2,2) - a(1,2)*a(2,1)
IF (det == 0) STOP ' el sistema no tiene solucion unica'
x(1) = (b(1)*a(2,2) - b(2)*a(1,2)) / det
x(2) = (b(2)*a(1,1) - b(1)*a(2,1)) / det

! Escritura de resultados
DO i=1,2
WRITE (12,9000) (x(j),j=1,2), x(i)
9000 FORMAT (20X,'Solucion x = ',2F12.4,5X,'BUENAS NOCHES',2X, F5.1)
enddo

ENDPROGRAM sistemas_de_dos_ecuaciones