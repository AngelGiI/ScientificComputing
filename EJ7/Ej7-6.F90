WRITE (6,'(A)',ADVANCE='NO') ' Introducir x '
READ (5,*) x
WRITE (6,'(A)',ADVANCE='NO') ' Introducir y '
READ (*,*) y

WRITE (*,*) x, y
WRITE (1,*) x**2, y**2
WRITE (2,*) x**3, y**3
WRITE (5,*) x**4, y**4
WRITE (6,*) x**5, y**5
PRINT*, x**6, y**6

END