OPEN (11, FILE='EJ7-16.sal')

x=-8.24 ; y=123.91
WRITE (11,9000) x, y
9000 FORMAT (2X,'x=',F10.5,5X,'y=',F5.1,:,'c=',F7.2//T8,'d=',F9.2)

! registro escrito:     bbx=bb-8.24000bbbbby=123.9

i=12 ; j=34 ; k=56
WRITE (11,9010) i, j, k
9010 FORMAT (1X,I2/2X,I2//3X,I2)

! 4 registros escritos:   b12
! bb34
! 
! bbb56
  WRITE (11,9020) i, j, k
9020 FORMAT (T5,I2,3X,I4,T15,I2)

! registro escrito:     bbbb12bbbbb34b56

a=73.2 ; b=5.7 ; n=327 ; m=542
WRITE (11,9030) a, b, n, m
9030 FORMAT (T20,F4.1,TL9,F3.1,TL15,I3,TR2,I3)

! registro escrito:     bb327bb542bbbb5.7bb73.2

END