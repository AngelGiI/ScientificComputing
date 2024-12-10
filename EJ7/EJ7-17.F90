OPEN (10, FILE='EJ7-17.sal')
BACKSPACE 10    ! sintaxis elemental
nb=3 ; i=28
BACKSPACE (nb+i/4)   ! el numero de unidad puede ser una expresion
BACKSPACE (nb+i/4,IOSTAT=ios,ERR=999)
999 PRINT*, ' ios =', ios
END