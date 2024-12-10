MODULE globales
  INTEGER nvar, nfile, nyear, ncity
  PARAMETER (nvar=20, ncity=50)
  REAL x(nvar,5)
  CHARACTER(LEN=20) ciudad(ncity)
ENDMODULE globales

PROGRAM ejemplo
USE globales
  PRINT*, ' nvar=', nvar
  CALL subrut
END

SUBROUTINE subrut
USE globales
  PRINT*, ' ncity=', ncity
END