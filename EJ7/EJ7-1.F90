INTEGER n, m, v(10)
REAL x(4,5)
CHARACTER(LEN=80) linea
CHARACTER(LEN=25) nombre(5)

PRINT*, ' Introducir n (<=5), m, v(1),...,v(10)'
READ*, n, m, v
PRINT*, 'v=', (v(i),i=1,10,4)      ! DO implicito de escritura

PRINT*, ' Introducir nombre(1),...,nombre(n)'
READ*, (nombre(i),i=1,n)           ! DO implicito de lectura

DO i=1,10; DO j=1,n; x(i,j)=i+j; ENDDO; ENDDO
PRINT*, x                          ! se escriben x(1,1),...,x(4,5)
PRINT*, ((x(i,j),j=1,4),i=1,3)     ! DO's implicitos anidados

linea = REPEAT('12345',16)
PRINT*, n, m, linea(3:20+2*n), v
PRINT*, ' n2=', n*n, ' rx', SQRT(x)
PRINT*, n, (i,i=1,20)
PRINT*, (v(3),i=1,15)

END