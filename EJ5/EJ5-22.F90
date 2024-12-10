10 PRINT*, ' Introducir pt'  ! aqui se va si RETURN 1
   READ*, pt
   CALL vuelta (pt, *10, result, *40, *20)
   pt = pt/2! aqui se va si RETURN o RETURN n (n>3)
   GOTO 40
20 IF (result .LE. 5) THEN   ! aqui se va si RETURN 3
     pt = pt*2
     GOTO 40
   ENDIF
40 CONTINUE ! aqui se va si RETURN 2
   PRINT*, ' result = ', result
END

SUBROUTINE vuelta (pt, *, result, *, *)
IF (pt < 0) RETURN 1
IF (0<=pt .AND. pt<=5) THEN
  result = 2.3
  RETURN 2
ENDIF
IF (7<=pt .AND. pt<=100) THEN
  result = pt**(1.0/3) - 3*pt + 24.5
  RETURN 3
ENDIF
result = pt
RETURN
END