INTEGER n, i, k(5), numeros(5,5)
REAL x(10)
CHARACTER(LEN=10) comunid(17)

DATA n,i/1,2/, k(2)/12345/, x/1.2,0.0,8*-3.5/
DATA ((numeros(i,j),i=1,j),j=1,5) /15*88/      ! DO implicito
DATA comunid/'ANDALUCIA','ARAGON',15*' '/

PRINT*, ' n=', n, ' i=', i, ' k(2)=', k
PRINT*; PRINT*, ' x=', x
PRINT*; PRINT*, ' numeros=', numeros
PRINT*; PRINT*, ' dos comunidades :', comunid(1), comunid(2)
END