PROGRAM ejercicio3_examen_angel
IMPLICIT NONE 

EXTERNAL fun

INTEGER, PARAMETER :: m = 40, nvar = 4
INTEGER i, info, nfev, ipvt(nvar)
DOUBLE PRECISION, PARAMETER :: tol = 10.d0**(-10), step = 10.d0**(-6)
DOUBLE PRECISION y(m), x(nvar), fjac(m,nvar), qtf(nvar)

! Abrimos el fichero de datos y el de resultados.   
OPEN (15, FILE='ejercicio3.DAT')
OPEN (16, FILE='ejercicio3.RESULT')

WRITE (16, '(3X,A/16X,A)') 'Ejercicio 3: MINCUAD-NL',  &
                         & '=========='
WRITE (16, '(/3X,A)') 'Alumno: GIL ALAMO ANGEL, AMANDO'

DO i = 1, 4
  x(i) = 1.d0
ENDDO

! LLAMAMOS A LA SUBRUTINA QUE HARA EL CALCULO.
! LMDIF ( fcn, m, n, x, fvec, ftol, xtol, gtol, maxfev, epsfcn, diag, mode, factor, nprint, 
!        info,  nfev, fjac, ldfjac, ipvt, qtf )
CALL LMDIF(fun, m, nvar, x, y, tol, tol, tol, 100000000, step, 1, 1, 100, -1, info, nfev, fjac, m, ipvt, qtf)

WRITE (16, '(4(2X,A,F16.10))') 'a= ',x(1),'b= ', x(2),'c= ', x(3),'d= ', x(4)

ENDPROGRAM ejercicio3_examen_angel

SUBROUTINE fun(m, nvar, x, y, iflag)

! Argumentos de entrada
IMPLICIT NONE
INTEGER m, nvar, iflag
DOUBLE PRECISION x(nvar), y(m)

! Variables locales
INTEGER i, j
DOUBLE PRECISION t(m,3)

! Abrimos aqui el fichero de datos para asignar las t(i,j) y las y(i).
OPEN (15, FILE='ejercicio3.DAT')

READ (15, '(/)')
DO i = 1, m
  READ (15, '(5X,4(2X,F12.10))') (t(i,j), j = 1,3), y(i)
  y(i) = (x(1) + x(2)*t(i,1) + x(3)/t(i,2)) / (x(4) + t(i,3)*EXP(x(2)))
ENDDO

RETURN

ENDSUBROUTINE fun