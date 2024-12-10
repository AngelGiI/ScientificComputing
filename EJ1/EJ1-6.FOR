      PROGRAM sistemas_de_dos_ecuaciones
      REAL a11, a12, a21, a22, b1, b2, det, x1, x2

!  Lectura de los coeficientes del fichero 'datos' (que ya debe existir)

      OPEN (11, FILE='datos')
      READ (11,*) a11, a12, b1, a21, a22, b2

!  Solucion del sistema

      det = a11*a22 - a12*a21   ! determinante de la matriz a
      IF (det .EQ. 0) STOP ' el sistema no tiene solucion unica'
      x1 = (b1*a22 - b2*a12) / det
      x2 = (b2*a11 - b1*a21) / det

!  Escritura de resultados en el fichero 'result' (lo crea el programa)

      OPEN (12, FILE='result')
      WRITE (12,9000) x1, x2
 9000 FORMAT (3X,'x1 = ',F12.4/3X,'x2 = ',F12.4)

      END