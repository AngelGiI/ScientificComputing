PROGRAM practica1_angel_gil
IMPLICIT NONE
DOUBLE PRECISION a, b, c, d, suma, p, alpha, x1, y1, x2, y2, x3, y3, &
  & x4, y4, h, aux, beta, area, u1, u2, u3, u4, v1, v2, v3, v4
INTEGER, PARAMETER:: n=5
INTEGER i

!Abrimos el fichero de datos y el de resultados.

OPEN (11, FILE='Practica1.DAT')
OPEN (12, FILE='Practica1.RESULT')

!Estudiamos cada caso.
    
DO i = 1, n  
  WRITE (12, '(/,2X,A,1X,I1)') 'Cuadrilatero', i
  WRITE (12, '(2X,A)') '---------------'
  IF (i .LE. 3) THEN  !Distinguimos los 3 primeros casos de los demás.
    READ (11,*) a, b, c, d, alpha 
    suma = a + b + c + d
    p = suma/2
    h = a**2 + b**2 - 2*a*b*cos(alpha)  !Calculamos beta mediante el teorema del coseno.
    aux = 0.5*(c/d + d/c - h/(c*d))
    
    !Nos aseguramos de que el cuadrilátero se puede resolver. 
    
    IF (ABS(aux)>1) THEN
      WRITE (12, '(/,10X,A,I1,A)') 'El cuadrilatero ', i, ' esta mal planteado.'
      
    !Trabajamos con los que esten bien planteados.
       
    ELSE
      beta= acos(aux) 
      WRITE (12, '(/,10X,A,F12.10)') 'beta = ',beta 
      area = sqrt((p-a)*(p-b)*(p-c)*(p-d) - a*b*c*d*cos((alpha+beta)/2)) !Calculamos el área.
      WRITE (12, '(/,10X,A,F15.10)') 'Area = ', area 
    ENDIF
  ELSE  !Casos 4 y 5.
    READ (11,*) x1, y1, x2, y2, x3, y3, x4, y4
        u1 = x1 - x2
        v1 = x3 - x2
        u2 = y1 - y2
        v2 = y3 - y2
        alpha = acos((u1*v1 + u2*v2)/(sqrt(u1**2 + u2**2)*sqrt(v1**2 + v2**2)))
        u3 = x3 - x4 
        v3 = x1 - x4 
        u4 = y3 - y4 
        v4 = y1 - y4
        beta = acos((u3*v3 + u4*v4)/(sqrt(u3**2 + u4**2)*sqrt(v3**2 + v4**2)))
        area = sqrt((p-a)*(p-b)*(p-c)*(p-d) - a*b*c*d*cos((alpha+beta)/2)) 
        WRITE (12, '(/,10X,A,F12.10)') 'alpha = ',alpha
        WRITE (12, '(10X,A,F12.10)') ' beta = ',beta
        WRITE (12, '(/,10X,A,F15.10)') 'Area = ', area 
  ENDIF     
ENDDO 
       
ENDPROGRAM practica1_angel_gil