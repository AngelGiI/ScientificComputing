/* Ejemplo Ej1-7 de Curso Basico de Fortran */

#include <stdio.h>
void main (void) {

float a[2][2], b[2], x[2], det;
char filedat[20], filesol[20];
int i, j;
FILE *f11, *f12;

/* Lectura de los nombres de los ficheros de datos y resultados */

printf ("%s", " fichero de datos = ") ; scanf ("%s", filedat);
f11 = fopen (filedat, "r");
printf ("%s", " fichero de resultados = ") ; scanf ("%s", filesol);
f12 = fopen (filesol, "w");

/* Lectura de los datos */

for (i=0; i<=1; i++) {
  for (j=0; j<=1; j++) fscanf (f11,"%f", &a[i][j]);
    fscanf (f11,"%f", &b[i]);
  }

/* Solucion del sistema */

det = a[0][0]*a[1][1] - a[0][1]*a[1][0];
if (det == 0) {
   printf ("%s"," el sistema no tiene solucion unica"); return; }

x[0] = (b[0]*a[1][1] - b[1]*a[0][1]) / det;
x[1] = (b[1]*a[0][0] - b[0]*a[1][0]) / det;

/*  Escritura de resultados */

fprintf (f12,"%s%12.4f%12.4f\n", "Solucion x = ", x[0], x[1]);

fclose (f11);
fclose (f12);
}

