      PRINT*, seno(1.04), SIN(1.04)
      END

! funcion de usuario seno

      FUNCTION seno(x)
          seno = x - x**3/factorial(3) + x**5/factorial(5)              &
     &               - x**7/factorial(7)
      CONTAINS
        INTEGER FUNCTION factorial(n)
          factorial = 1
          DO i = n, 1, -1
            factorial = factorial*i
          ENDDO
        END FUNCTION factorial
      END FUNCTION seno