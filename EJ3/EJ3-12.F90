CHARACTER uno*10, dos*8, todo*18
CHARACTER(LEN=15), DIMENSION(100):: color
uno = 'PRIMERO'
dos = ' SEGUNDO'
color(23)= 'magenta'

todo = uno // dos
PRINT*,' todo = ', todo       ! todo = 'PRIMERO    SEGUNDO'

PRINT*,'abc'//'EF'//'1 2 3'   ! 'abcEF1 2 3'

PRINT*, uno(3:5)//color(23)(2:5)//dos(1:4)     ! 'IMEagen SEG'
END