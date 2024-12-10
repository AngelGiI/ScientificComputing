/* Ejemplo Ej1-3 de Curso Basico de Fortran */

#include <stdio.h>
#include <math.h>
main () {
int n;
float x1, x2, x3, x4, x5, suma, xmed, varianza;

n = 5;
x1 = 1.23;
x2 = 2.34;
x3 = 3.45;
x4 = 4.56;
x5 = 5.67;
suma = x1 + x2 + x3 + x4 + x5;
xmed = suma / n;
varianza = pow(x1-xmed,2) + pow(x2-xmed,2) + pow(x3-xmed,2) +
           pow(x4-xmed,2) + pow(x5-xmed,2);
varianza = varianza / n;
printf ("suma = %f", suma);
printf ("\nmedia = %f", xmed);
printf ("\nvarianza = %f\n", varianza);

/* Las siguientes sentencias son mas proximas a la sintaxis Fortran */

printf ("\n%s%f", "suma = ", suma);
printf ("\n%s%f", "media = ", xmed);
printf ("\n%s%f\n", "varianza = ", varianza);
}

