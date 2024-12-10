REAL x(1000), m(50,300)
OPEN (11, FILE='EJ7-12.sal')

CALL RANDOM_NUMBER (x)
CALL RANDOM_NUMBER (m)

! se escriben los 20 elementos: x(50),x(100),...,x(1000)
! con formato 5F15.5, esto es, 4 registros con 5 elementos por registro

WRITE (11, '(5F15.5)') (x(i),i=50,1000,50)

! se escriben los 36 elementos: m(1,1), m(1,2), m(2,2),
! m(1,3),m(2,3),.m(3,3),...,m(1,8),...m(8,8) con formato 5F7.4, esto es,
! 6 registros con 5,5,5,5,5,5,1 elementos.

WRITE (11, '(5F7.4)') ((m(i,j),i=1,j),j=1,8)

END