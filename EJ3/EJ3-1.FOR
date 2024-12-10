      n = 100
      suma = 0
      DO i = 1, n
        suma = suma + i*i
      ENDDO
      media = suma/n

      dt = 0
      DO i = 1, n
        dt = dt + (i*i-media)**2
      ENDDO
      dt = SQRT(dt/n)

      IF (dt .LT. media) PRINT *, ' La desviacion tipica de la muestra f
     &ormada por los numeros 1, 4, 9, 16, ... , 10000 es menor que su me
     &dia'
      PRINT*, media, dt
      END