REAL a, b, c, x1, x2
INTEGER indice

PRINT*, ' Introducir la ecuacion de segundo grado: a, b, c'
READ*, a, b, c

CALL segundo (a, b, c, x1, x2, indice)

SELECT CASE (indice)
  CASE (0)
  PRINT*, ' a=b=0. No existe ecuacion'
  CASE (1)
  PRINT*, ' a=0. Ecuacion de primer grado. Solucion x= ', x1
  CASE (2)
  PRINT*, ' Raiz real doble x = ', x1
  CASE (3)
  PRINT*, ' Raices complejas conjugadas:', x1, ' +/- ', x2, ' i'
  CASE (4)
  PRINT*, ' Raices reales simples: x1=', x1, ' x2=', x2
ENDSELECT

END

! Subprograma SUBROUTINE

SUBROUTINE segundo (a, b, c, x1, x2, indice)
REAL, INTENT(IN):: a, b, c     ! argumento ficticio de entrada
REAL, INTENT(OUT):: x1, x2     ! argumento ficticio de salida
INTEGER, INTENT(OUT):: indice  ! argumento ficticio de salida
REAL disc                      ! variable local

indice = 0                   ! no existe ecuacion
IF (a==0 .AND. b==0) RETURN
IF (a == 0) THEN
  indice = 1                 ! ecuacion de primer grado
  x1 = -c/b
  x2 = x1
  RETURN
ENDIF

disc = b**2 - 4*a*c
IF (disc == 0) THEN
  indice = 2                 ! raiz real doble
  x1 = -b / (2.*a)
  x2 = x1
  RETURN
ENDIF

IF (disc < 0) THEN
  indice = 3                 !  raices complejas conjugadas
  x1 = -b / (2.*a)           !  x1 contiene la parte real
  x2 = SQRT(-disc)/(2.*a)    !  x2 contiene la parte imaginaria
ELSE
  indice = 4                 !  raices reales simples
  x1 = (-b+SQRT(disc))/(2.*a)
  x2 = (-b-SQRT(disc))/(2.*a)
ENDIF

END