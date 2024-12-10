INTEGER, PARAMETER:: n=5
INTEGER, DIMENSION(n,n):: a, b

i = 0
10 i = i + 1

j = 0
20 j = j+1

IF (j == i) THEN
  IF (j == 1) THEN
    a(i,j) = 1
  ELSE
    a(i,j) = 2
  ENDIF
ELSEIF (ABS(i-j) == 1) THEN   ! ABS es el valor absoluto
  a(i,j) = -1
ELSE
  a(i,j) = 0
ENDIF

! Otra forma equivalente es

b(i,j) = 0
IF (j==i .AND. j==1) b(i,j)=1
IF (j==i .AND. j>1) b(i,j)=2
IF (ABS(i-j) == 1) b(i,j)=-1
IF (a(i,j) /= b(i,j)) STOP ' Error de programa'

PRINT*, ' a(', i, ',', j, ')=', a(i,j)

IF (j < n) GOTO 20
IF (i < n) GOTO 10
END