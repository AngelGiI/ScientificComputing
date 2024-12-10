/* Ejemplo Ej1-6 de Curso Basico de Fortran */

#include <stdio.h>
void main (void) {

float a11, a12, a21, a22, b1, b2, det, x1, x2;

/* Lectura de los coeficientes del fichero 'datos' (que ya debe existir) */

FILE *f11, *f12;
f11 = fopen ("datos", "r");

fscanf (f11,"%f%f%f%f%f%f", &a11, &a12, &b1, &a21, &a22, &b2);

/* Solucion del sistema */

det = a11*a22 - a12*a21;   /* determinante de la matriz a */
if (det == 0) {
   printf ( "%s"," el sistema no tiene solucion unica"); return; }

x1 = (b1*a22 - b2*a12) / det;
x2 = (b2*a11 - b1*a21) / det;

/* Escritura de resultados en el fichero 'result' (lo crea el programa) */

f12 = fopen ("result-c", "w");

fprintf (f12,"%8s%12.4f\n%8s%12.4f\n", "x1 = ", x1, "x2 = ", x2);

fclose (f11);
fclose (f12);
}

