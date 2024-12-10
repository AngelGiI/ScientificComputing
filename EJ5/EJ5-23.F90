CHARACTER(LEN=9), DIMENSION(3,4):: var1
CHARACTER(LEN=10), DIMENSION(3,4):: var2
CHARACTER(LEN=*), PARAMETER:: letras = 'abcdefghijkl'
CALL asumid (3, 4, 10, var1, var2)
PRINT*, letras
PRINT*, var1
PRINT*, var2
END

SUBROUTINE asumid(n1, n2, m, car1, car2)
INTEGER n1, n2, m
CHARACTER(LEN=*), DIMENSION(n1,n2):: car1  ! longitud asumida
CHARACTER(LEN=m), DIMENSION(n1,n2):: car2  ! longitud fija
car1 = 'fiesta'
car2 = 'de navidad'
END