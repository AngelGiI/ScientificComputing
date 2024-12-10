10 PRINT*, ' Introducir i'          ! aqui se va si i=1
READ*, i

GOTO (10,20,30,20) i             ! la coma es opcional

PRINT*, ' i<1 o i>4, i=', i      ! aqui se continua si i<1 o i>4
GOTO 40
20 PRINT*, ' i=2 o i=4, i=', i      ! aqui se va si i=2 o i=4
GOTO 40
30 PRINT*, ' i=3, i=', i            ! aqui se va si i=3
40 CONTINUE

END