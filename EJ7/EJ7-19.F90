OPEN (10, FILE='EJ7-19.sal')
! ENDFILE 10 ! sintaxis elemental
nb=3 ; i=28
! ENDFILE (nb+i/4)! el numero de unidad puede ser una expresion
ENDFILE (nb+i/4,IOSTAT=ios,ERR=999)
999 PRINT*, ' ios =', ios
END