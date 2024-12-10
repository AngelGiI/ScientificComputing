CHARACTER(LEN=10) ciudad(20)
j = 7
i = 5
ciudad(j) = 'madrid'
OPEN (j, FILE=ciudad(j))
OPEN (10*i+j, FILE=ciudad(j)//'.sal')
WRITE (j,'(A,I2)') ' Se ha abierto el fichero ', j
WRITE (10*i+j,'(A,I2)') ' Se ha abierto el fichero ', 10*i+j
END