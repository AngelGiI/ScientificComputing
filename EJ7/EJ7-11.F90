OPEN (11, FILE='EJ7-11.dat')
OPEN (12, FILE='EJ7-11.sal')

READ (11, '(5F6.3)') a, b, c, d, e
WRITE (12, '(5F10.3)') a, b, c, d, e                        ! reg1
WRITE (12, '(E10.3,E8.2,E10.2,E6.1,E9.3)') a, b, c, d, e    ! reg2
WRITE (12, '(G10.3,G8.3,G10.4,G10.3,G12.5)') a, b, c, d, e  ! reg3
PRINT*, a, b, c, d, e
END