PROGRAM ejercicio1_examen_angel
IMPLICIT NONE 

INTEGER  i, j
DOUBLE PRECISION a, fa, b, fb, c, fc, e1, e2, e3, e4, v, w
DOUBLE PRECISION V0(3), V1(3), V2(3), V3(3), V4(3), V5(3)
! Abrimos el fichero de datos y el de resultados.   

OPEN (11, FILE='ejercicio1.DAT')
OPEN (12, FILE='ejercicio1.RESULT')

WRITE (12, '(3X,A/16X,A)') 'Ejercicio 1: VERTICE DE LA PARABOLA DE SEGUNDO GRADO',  &
                         & '======================================='
WRITE (12, '(/3X,A)') 'Alumno: GIL ALAMO ANGEL, AMANDO'

READ (11, '(/)')

DO i = 1, 9
  READ (11, '(/12X,F5.3,1X,F5.3,5X,F5.3,1X,F5.3,5X,F5.3,1X,F5.3)') a, fa, b, fb, c, fc
  
  V0 = (/fa, fb, fc/)
  V1 = (/b-c, c-a, a-b/)
  V2 = (/b+c, c+a, a+b/)
  V3 = (/b*c, c*a, a*b/)
  
  DO j = 1, 3
    V4(j) = V2(j) * V1(j)
	V5(j) = V3(j) * V1(j)
  ENDDO
  e1 = DOT_PRODUCT(V4,V0)
  e2 = DOT_PRODUCT(V1,V0)
  e3 = V1(1) * V1(2) * V1(3)
  e4 = DOT_PRODUCT(V5,V0)
  
  v = e1 / e2 * 2.d0
  w = ( (1.d0/2.d0) * v * e1 - e4 ) / e3
  WRITE (12, '(/3X,A,I1,A,F8.3,A,F8.3,A)',ADVANCE='NO') 'Caso ', i, ' (v,w)= (',v, ',', w, ')' 
  
  IF (e2 > 0) THEN
    WRITE (12, '(2X,A)') 'Tipo: MAX'
  ELSE
    WRITE (12, '(2X,A)') 'Tipo: MIN'
  ENDIF
  
ENDDO
ENDPROGRAM ejercicio1_examen_angel