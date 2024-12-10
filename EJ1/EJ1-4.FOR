!  Declaracion de variables

      INTEGER n, i
      REAL x(100)
      REAL suma, media, varianza

!  Definicion de los 100 primeros numeros impares

      n = 100
      DO i = 1, n
        x(i) = 2*i - 1
      ENDDO

!  Calculo de la suma, media y varianza

      suma = 0             ! Iniciacion de suma
      DO i = 1, n
        suma = suma + x(i)
      ENDDO

      media = suma / n

      varianza = 0         ! Iniciacion de varianza
      DO i = 1, n
        varianza = varianza + (x(i)-media)**2
      ENDDO
      varianza = varianza / n

!  Escritura de resultados

      PRINT*, 'suma = ', suma
      PRINT*, 'media = ', media
      PRINT*, 'varianza = ', varianza

      END