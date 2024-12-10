INTEGER:: a, x, n
DOUBLE PRECISION doble
COMPLEX:: c, d
CHARACTER(LEN=10) nombre, vocales*5, comput
LOGICAL:: logico, zz
PARAMETER (n=5, r=89.34, pi=3.141592, lac=-40, zz=.FALSE.,         &
           c=(2.45e2,-1.17), comput='ordenador', vocales='aeiou')

!  daria error poner n=8 porque no se puede cambiar un parametro

x = 215
doble = 6345.700234512846d-125
logico = .TRUE.
d = (2,4.5)
a = 1200
x = -1                ! se puede cambiar el valor de una variable
nombre = 'Tarzán'     ! atencion al acento en algunos compiladores
PRINT*, pi, x, doble, logico, d, a
PRINT*, nombre, vocales
END