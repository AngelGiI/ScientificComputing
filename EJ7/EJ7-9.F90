REAL x(100), y(500)
OPEN (11, FILE='EJ7-9.sal')

DO i = 1, 100
  x(i) = SIN(0.01*i)
ENDDO
WRITE (11, 9000) (x(i),i=1,100)
9000 FORMAT (3X,'x = ',(T11,5F10.5))

DO n = 1, 500
  y(n) = SQRT(REAL(n))
ENDDO
WRITE (11, 9100) (n,y(n),n=1,500)
9100 FORMAT (5X,(' n=',I3,T20,F8.5))  ! con este formato el codigo 5X
                                      ! solo se aplica al primer registro
!9100 FORMAT (5X,' n=',I3,T20,F8.5)   ! este formato es preferible
END