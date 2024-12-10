LOGICAL log1, log2, log3
OPEN (11, FILE='EJ7-13.dat')
OPEN (12, FILE='EJ7-13.sal')

READ (11, '(2L3,L5)') log1, log2, log3
WRITE (12, '(3L2)') log1, log2, log3
PRINT*, log1, log2, log3
END