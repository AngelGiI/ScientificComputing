n = 5
x1 = 1.23
x2 = 2.34
x3 = 3.45
x4 = 4.56
x5 = 5.67
suma = x1 + x2 + x3 + x4 + x5
xmed = suma / n
varianza = (x1-xmed)**2 + (x2-xmed)**2 + (x3-xmed)**2 +   &
           (x4-xmed)**2 + (x5-xmed)**2
varianza = varianza / n
PRINT*, 'suma = ', suma
PRINT*, 'media = ', xmed
PRINT*, 'varianza = ', varianza
END