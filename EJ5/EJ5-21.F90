INTEGER longitud(6)
CHARACTER(LEN=12) nombres(6)
COMMON /uno/ x, y, z
COMMON /nrios/ nombres
COMMON /lrios/ longitud
  PRINT*, x, y, z
  PRINT*, nombres
  PRINT*, longitud
END

BLOCK DATA
COMMON /uno/ a, b, c
  DATA a,b,c /1.0,2.0,3.0/
ENDBLOCK DATA

BLOCK DATA datrios
INTEGER long(6)
CHARACTER(LEN=12) nomb(6)
COMMON /nrios/ nomb
COMMON /lrios/ long
  DATA nomb /'MIÑO','DUERO','TAJO','GUADIANA','GUADALQUIVIR','EBRO'/
  DATA long(3) /1008/
ENDBLOCK DATA datrios