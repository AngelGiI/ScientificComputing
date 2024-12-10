PROGRAM interno

  CALL coefbinomial ! invoca una subrutina interna

CONTAINS

  SUBROUTINE coefbinomial
    INTEGER n, k
    CALL leer(n)    ! invoca una subrutina interna
    DO k = 0, n
      PRINT*, k, nsobrek(n,k)     ! invoca una funcion interna
    ENDDO
  ENDSUBROUTINE coefbinomial

  SUBROUTINE leer(n)
    INTEGER n
    PRINT*, ' Introducir el valor de n'
    READ*, n
  ENDSUBROUTINE leer

  FUNCTION nsobrek(n,k)
    INTEGER nsobrek, n, k
    nsobrek = fact(n) / (fact(k)*fact(n-k)) ! invoca una funcion
  ENDFUNCTION nsobrek                       ! interna 3 veces

  FUNCTION fact(m)
    REAL fact
    INTEGER m, i
    fact = 1
    DO i = 2, m
      fact = i*fact
    ENDDO
  ENDFUNCTION fact

ENDPROGRAM interno