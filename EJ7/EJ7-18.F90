OPEN (10, FILE='EJ7-18.sal')
REWIND 10              ! sintaxis elemental
nb=3 ; i=28
REWIND (nb+i/4)        ! el numero de unidad puede ser una expresion
REWIND (nb+i/4,IOSTAT=ios,ERR=999)
999 PRINT*, ' ios =', ios
END