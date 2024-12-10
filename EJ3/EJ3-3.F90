CHARACTER(LEN=200) nombre_largo

WRITE (*,'(A)',ADVANCE='NO') 'y = '
READ*, y

t1cosh = EXP(y) +  &   ! Linea inicial de la sentencia
         EXP(-y)       ! Continuacion

t2cosh = EXP(y) +  &   ! Linea inicial de la sentencia
       & EXP(-y)       ! Continuacion

t3cosh = EXP(y) + EX&  ! Linea inicial de la sentencia
         &P(-y)        ! Continuacion

nombre_largo = &
   'De un lugar de la Mancha &
   &cuyo nombre no se si alguien sabra &
   &se escribio un famoso libro &
   &que EL QUIJOTE vinose a llamar'

PRINT*, y, t1cosh, t2cosh, t3cosh
PRINT*, nombre_largo
END