REAL x(5,7), y(7,20), s(5,20), a(20), b(20), c(7), d(5), st(20,5)
COMPLEX z(20), zta

DO i=1,20; a(i)=1.23*i; b(i)=2*i-1; z(i)=CMPLX(a(i),b(i)); ENDDO
DO i=1,5; DO j=1,7; x(i,j)=i+j-2; ENDDO; ENDDO
DO i=1,7; DO j=1,20; y(i,j)=i*j+1; ENDDO; ENDDO
DO i=1,7; c(i)=i**3; ENDDO
DO i=1,5; DO j=1,20; s(i,j)=i-j**2; ENDDO; ENDDO

atb = DOT_PRODUCT(a,b)
zta = DOT_PRODUCT(z,a)
st = TRANSPOSE(MATMUL(x,y))
b = MATMUL(c,y)
d = MATMUL(s,b)

PRINT*, ' atb=', atb, ' zta=', zta
END