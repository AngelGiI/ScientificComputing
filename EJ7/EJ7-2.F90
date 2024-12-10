CHARACTER(LEN=20) form1

PRINT '(A)', ' Introducir ivar1, ivar2 con formato (I6,I3)'
READ '(I6,I3)', ivar1, ivar2

form1='(I5,I8)'
PRINT '(A,A)', ' Introducir n1, n2 con formato ', form1
READ form1, n1, n2

PRINT '(A)', ' Introducir m1, m2 con formato (I7,I4)'
READ 8000, m1, m2
8000 FORMAT (I7,I4)

PRINT '(I9,I8)', ivar1, ivar2
PRINT 9000, n1, n2
PRINT form1, m1, m2
9000 FORMAT (I11,I6)

END