CHARACTER(LEN=30) nomb
nfile = 3; nf = 3; nomb = 'cilindro.sal'
OPEN (UNIT=3, FILE='cilindro.sal')  ! estas cuatro sentencias
OPEN (3, FILE='cilindro.sal')       ! son equivalentes
OPEN (nfile, FILE='cilindro.sal')   ! si nfile=3
OPEN (nf, FILE=nomb)                ! si nf=3, nomb='cilindro.sal'
WRITE (3,'(A)') ' El fichero 3 ha sido abierto'
END