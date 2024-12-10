PROGRAM regresion
INTEGER m, i, indic
INTEGER, PARAMETER:: mmax=100
REAL x(mmax), y(mmax), p, q
CHARACTER(LEN=30) filedat, filesol

! Lectura de los nombres de los ficheros de datos y de resultados

WRITE (*,'(A)',ADVANCE='NO') ' fichero de datos = '
READ (*,'(A)') filedat
OPEN (11, FILE=filedat)
WRITE (*,'(A)',ADVANCE='NO') ' fichero de resultados = '
READ (*,'(A)') filesol
OPEN (12, FILE=filesol)

! Lectura de la nube de puntos

READ (11,*) m
IF (m > mmax) STOP ' m es demasiado grande'
READ (11,'(8F10.5)') (x(i),i=1,m)
READ (11,'(8F10.5)') (y(i),i=1,m)

! Calculo y escritura de la recta de regresion

CALL regres (x, y, m, p, q, indic)
IF (indic == 0) THEN
  WRITE (12,9000) p, q
  9000 FORMAT (3X,'p = ',F12.4/3X,'q = ',F12.4)
ELSE
  WRITE (12,'(A)') ' no hay recta de regresion'
ENDIF

ENDPROGRAM regresion

! Subrutina que calcula la recta de regresion

SUBROUTINE regres (x, y, m, p, q, indic)
INTEGER m, indic
REAL x(*), y(*), p, q

!  Variables locales

INTEGER i
REAL sumx2, sumx, sumxy, sumy, d

!  Calculo de las sumas sumx2, sumx, sumxy, sumy

sumx2 = 0
sumx = 0
sumxy = 0
sumy = 0
DO i = 1, m
  sumx2 = sumx2 + x(i)**2
  sumx = sumx + x(i)
  sumxy = sumxy + x(i)*y(i)
  sumy = sumy + y(i)
ENDDO

!  Calculo de p, q

d = m*sumx2 - sumx**2
IF (d == 0) THEN
  indic = 1
ELSE
  indic = 0
  p = (m*sumxy - sumx*sumy) / d
  q = (sumy - p*sumx) / m
ENDIF

ENDSUBROUTINE regres