PROGRAM practica3_angel_gil
IMPLICIT NONE
INTEGER n(4), i, k, a
DOUBLE PRECISION x, sum(4), suma(4), r(4), p, q

!Abrimos el fichero de datos y el de resultados.   

OPEN (15, FILE='Practica3.DAT')
OPEN (16, FILE='Practica3.RESULT')

!Escribimos las primeras filas de la tabla de salida.
!También leemos y asignamos los valores de n (los casos).

WRITE (16, '(2/,2X,A)') '|=================================================================================|'
READ (15, '(/,21X,I3,11X,I4,10X,I5,9X,I6)') n(1), n(2), n(3), n(4)
WRITE (16, '(2X,A,10X,I3,1X,A,9X,I4,1X,A,8X,I5,1X,A,7X,I6,1X,A,5X,A,5X,A)') '| n--> |', n(1), &
& '|', n(2), '|', n(3), '|', n(4), '|', 'p(a)', '|'
WRITE (16, '(2X,A)') '|=================================================================================|'
WRITE (16, '(2X,A)',ADVANCE='NO')  '| S(n) |'

!Primer bucle, calculamos el valor de S(n) para cada caso.
!Lo almacenamos como vector (sum(i)) porque lo usaremos de nuevo más adelante.

DO i = 1, 4
  sum(i) = 0.0
  DO k = n(i), 1, -1        !Realizamos la suma de mayor a menor para mayor precision.
    x = 1.d0/ (DBLE(k)*(DBLE(k)+1.d0)*(DBLE(k)+2.d0))
    sum(i) = sum(i) + x
  ENDDO
  WRITE (16, '(F14.10,A)',ADVANCE='NO') sum(i), '|'
ENDDO

!Seguimos construyendo la tabla.

WRITE (16, '(1X,A,1X,A)') 'xxxxxxxxxxxx', '|'
WRITE (16, '(2X,A)') '|=================================================================================|'

!Calculamos r(a,n) para los valores de a y n indicados.

DO a = 2, 10    !Primer bucle para los valores de a.
  WRITE (16, '(2X,A,I2,A)',ADVANCE='NO') '|a = ', a, '|'
  
  DO i = 1, 4    !Segundo bucle para los valores de n.
    suma(i) = 0.0
    
    DO k = a*n(i), 1, -1    !El tercer bucle es en el que hacemos los cálculos de S(a*n).
      x = 1.d0/(DBLE(k)*(DBLE(k)+1.d0)*(DBLE(k)+2.d0))
      suma(i) = suma(i) + x
    ENDDO
    
    r(i) = DBLE(n(i))**2 * (suma(i) - sum(i))    !Finalmente calculamos r(a,)
    WRITE (16, '(F14.10,A)',ADVANCE='NO') r(i), '|'
  ENDDO
  
!Calculamos y escribimos p(a) siguiendo la formula obtenida en el pdf.

  p = (a ** 2 - 1.0) / (2.0 * a**2)
  WRITE (16, '(F14.10,,A)') p, '|'
  
  IF (a == 10) EXIT     !La última linea de la tabla será distinta.
  WRITE (16, '(2X,A)') '|---------------------------------------------------------------------------------|'
ENDDO

WRITE (16, '(2X,A)') '|=================================================================================|'
WRITE (16, '(2X,A)',ADVANCE='NO') '| q(n) |'

!Calculamos y escribimos q(n) siguiendo la formula.

DO i = 1, 4
  q = DBLE(n(i))**2 / (2*DBLE(n(i))**2 + 6*DBLE(n(i)) + 4.0)
  WRITE (16, '(F14.10,A)',ADVANCE='NO') q, '|'
ENDDO

WRITE (16, '(1X,A,1X,A)') 'xxxxxxxxxxxx', '|'
WRITE (16, '(2X,A)') '|=================================================================================|'
write (16, '(4F14.10,//)') suma(:), sum(:), r(:) 
ENDPROGRAM practica3_angel_gil