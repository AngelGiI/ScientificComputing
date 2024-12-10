INTEGER n
REAL x
DOUBLE PRECISION d
COMPLEX c
LOGICAL l
CHARACTER*20 car

n = -12; PRINT*, n
n = 38563; PRINT*, n
n = 0; PRINT*, n
n = -50546874; PRINT*, n
! Las siguientes constantes enteras no son validas
!  n = 5.7456; PRINT*, n
!  n = -3457356467; PRINT*, n
!  n = 2147483648; PRINT*, n
!  n = 12e2; PRINT*, n

x = 5.6345; PRINT*, x
x = 38896.45e12; PRINT*, x
x = -45.67e-31; PRINT*, x
x = 7.45e0; PRINT*, x
! Las siguientes constantes reales no son validas
! x = 1,565; PRINT*, x
! x = -563.56e-58; PRINT*, x
! x = 96789678968946; PRINT*, x
! x = 3.46e2.6; PRINT*, x

d = 0.56345d1; PRINT*, d
d = -8.23452d0; PRINT*, d
d = 38896.45d120; PRINT*, d
d = 45.67d-300; PRINT*, d
! Las siguientes constantes doble precision no son validas
! d = 1,565; PRINT*, d
! d = 7.8567e39; PRINT*, d
! d = -563.56d-5879; PRINT*, d
! d = 96789678968946; PRINT*, d

c = (1.3,4.5); PRINT*, c
c = (-0.45e10,7.23); PRINT*, c
c = (2.d13,-5.764d-1); PRINT*, c
c = (0,1); PRINT*, c
! Las siguientes constantes complejas no son validas
! c = (2.3e66,1.3); PRINT*, c
! c = 4.5,3.98; PRINT*, c
! c = (3.0,i); PRINT*, c
! c = (12345678912345,7.2); PRINT*, c

l = .TRUE.; PRINT*, l
l = .false.; PRINT*, l
! Las siguientes constantes logicas no son validas
! l = .T.; PRINT*, l
! l = .FALSO.; PRINT*, l

car = 'hola ¿que tal?'; PRINT*, car
car = 'O''DONNELL'; PRINT*, car    
! Las siguientes constantes caracter no son validas
! car = 'lunes"; PRINT*, car
! car = 'O'DONNELL'; PRINT*, car

END