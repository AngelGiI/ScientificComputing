CHARACTER(LEN=20) form1, form2
INTEGER x(100)

! Contenido del fichero EJ7-5a.dat:  3  2 10 15 20

OPEN (8, FILE='EJ7-5a.dat')
READ (8,'(5I3)') ivar1, ivar2, n1, n2, nsal
PRINT*, 'Introducir x(1), x(2) con formato (I3,I5)'
form1='(I3,I5)'
READ (*,form1) x(1), x(2)

! Contenido del fichero EJ7-5b.dat: 9 60 61 62 63 64 65

OPEN (ivar1, FILE='EJ7-5b.dat')   ! ivar1=3
READ (ivar1,*) nvariab, (x(i),i=n1,n2)
CLOSE (ivar1)

! Contenido del fichero EJ7-5c.dat: 2 4

OPEN (ivar1, FILE='EJ7-5c.dat')   ! ivar1=3
READ (3,8000) m1, m2
8000 FORMAT (2I2)
WRITE (*,*) m1, m2
CLOSE (2+ivar1)

OPEN (m1*m2+1, FILE='EJ7-5d.sal') ! m1*m2+1=9
WRITE (m1*m2+1,'(2I4)') n1, n2
WRITE (*,8000) n1, n2
WRITE (9,*) (x(n1+i),i=0,n2-n1)
form2='(2I5)'
WRITE (nvariab,form2) n1, n2      ! nvariab=9

END