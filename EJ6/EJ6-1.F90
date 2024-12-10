PROGRAM ej6_1

x=3.45; y=23.5
PRINT*, ' ABS     ', ABS(x+3*y-4)     , '     ', ABS((3.0,-4.0))
PRINT*, ' AIMAG   ', AIMAG((2.4,-5.8)), '     ', AIMAG(CMPLX(1+x,3-y))
PRINT*, ' AINT    ', AINT(23.67)      , '     ', AINT(-23.67)
PRINT*, ' ANINT   ', ANINT(7.2)       , '     ', ANINT(-7.2)
PRINT*, ' ANINT   ', ANINT(7.5)       , '     ', ANINT(-7.5)
PRINT*, ' ANINT   ', ANINT(7.9)       , '     ', ANINT(-7.9)
PRINT*, ' CEILING ', CEILING(7.2)     , '     ', CEILING(-7.2)
PRINT*, ' CMPLX   ', CMPLX(2)         , '     ', CMPLX(2.5)
PRINT*, ' FLOOR   ', FLOOR(7.2)       , '     ', FLOOR(-7.2)
PRINT*, ' INT     ', INT(7.2)         , '     ', INT(-7.2)
PRINT*, ' INT     ', INT((2.3,7.9))   , '     ', INT((-2.3,7.9))
PRINT*, ' NINT    ', NINT(7.2)        , '     ', NINT(7.5)
PRINT*, ' NINT    ', NINT(7.9)
!  PRINT*, NINT((2.3,4.5))   ! argumento invalido
PRINT*, ' REAL    ', REAL(2)          , '     ', REAL((3.6,4.8))

ENDPROGRAM ej6_1