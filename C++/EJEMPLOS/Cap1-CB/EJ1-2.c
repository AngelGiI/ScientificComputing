/* Ejemplo Ej1-2 de Curso Basico de Fortran */

#include <stdio.h>
#include <math.h>
main () {
float x, y, epi, fxy;
x = 2.3 + 5.2*4.78;
y = sqrt(pow(x,2)+3.5);
epi = exp(1.0) + 2*asin(1.0);
printf ("%s %f %s %f", "x = ", x, "y = ", y);
printf ("\n%s %10.3f", "e + pi = ", epi);
fxy = log(0.1*x)/(sin(y)+1.2) - pow(x+1,2.6) +       /* C no tiene */
      5*x/(x*y+1);                    /* indicador de continuacion */
printf ("\n%s%10.3f\n", "f(x,y) = ", fxy);
}

