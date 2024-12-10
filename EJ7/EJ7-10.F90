OPEN (11, FILE='EJ7-10.dat')
! OPEN (11, FILE='EJ7-10.dat', BLANK='ZERO')
OPEN (12, FILE='EJ7-10.sal')

READ (11, '(I6,3I2,I3,I4)') i, j, k, l, m, n
WRITE (12, '(2I5,I4.2,I2,I2,I6.5)') i, j, k, l, m, n
PRINT*, i, j, k, l, m, n
END