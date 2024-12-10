CHARACTER(LEN=14) fmt
INTEGER k(8)
REAL x(20)

OPEN (11, FILE='EJ7-20.sal')
DO i=1,8; k(i)=i**3; ENDDO
CALL RANDOM_NUMBER (x)

DO n = 1, 8
  DO m = 2, 4
    WRITE (fmt,9000) n, m                     ! se construye el formato:
    9000 FORMAT ('(',I1,'I5,3X,',I1,'F7.4)')  ! (nI5,3X,mF7.4)
    PRINT*, fmt
    WRITE (11, fmt) (k(i),i=1,n), (x(j),j=1,m)
  ENDDO
ENDDO
END