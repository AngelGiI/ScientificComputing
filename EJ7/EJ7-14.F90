CHARACTER(LEN=4) car1, car2, car3, car4
OPEN (11, FILE='EJ7-14.dat')
OPEN (12, FILE='EJ7-14.sal')

READ (11, '(A3,A,A4,A5)') car1, car2, car3, car4
WRITE (12, '(A,A2,A6,A4)') car1, car2, car3, car4
PRINT*, car1, car2, car3, car4
END