      PROGRAM sistemas_de_dos_ecuaciones
      REAL a(2,2), b(2), x(2), det
      CHARACTER(LEN=20) filedat, filesol

!  Lectura de los nombres de los ficheros de datos y resultados

      WRITE (*,'(A)',ADVANCE='NO') ' fichero de datos = '
      READ (*,'(A)') filedat
      OPEN (11, FILE=filedat)
      WRITE (*,'(A)',ADVANCE='NO') ' fichero de resultados = '
      READ (*,'(A)') filesol
      OPEN (12, FILE=filesol)

!  Lectura de los datos

      READ (11,*) (a(1,j),j=1,2), b(1)
      READ (11,*) (a(2,j),j=1,2), b(2)

!  Solucion del sistema

      det = a(1,1)*a(2,2) - a(1,2)*a(2,1)
      IF (det .EQ. 0) STOP ' el sistema no tiene solucion unica'
      x(1) = (b(1)*a(2,2) - b(2)*a(1,2)) / det
      x(2) = (b(2)*a(1,1) - b(1)*a(2,1)) / det

!  Escritura de resultados

      WRITE (12,9000) (x(j),j=1,2)
 9000 FORMAT (3X,'Solucion x = ',2F12.4)

      END