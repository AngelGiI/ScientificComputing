/* Ejemplo Ej1-8 de Curso Basico de Fortran */

#include <stdio.h>
#include <math.h>
#define mmax 100

void main (void) {

int m, i, indic;
float x[mmax], y[mmax], p, q;
char filedat[30], filesol[30];              

void regres (float[], float[], int, float*, float*, int*);

FILE *f11, *f12;

/* Lectura de los nombres de los ficheros de datos y resultados */

printf ("%s", "fichero de datos = ") ; scanf ("%s", filedat);
f11 = fopen (filedat, "r");
printf ("%s", "fichero de resultados = ") ; scanf ("%s", filesol);
f12 = fopen (filesol, "w");

/* Lectura de la nube de puntos */

fscanf (f11, "%d", &m);
if (m > mmax) {
  printf ("%s", " m es demasiado grande"); return; }

for (i=0; i<m; i++) fscanf (f11,"%f", &x[i]);
for (i=0; i<m; i++) fscanf (f11,"%f", &y[i]);

/* Calculo y escritura de la recta de regresion */

regres (x, y, m, &p, &q, &indic);
if (indic == 0)
  fprintf (f12, "%s%12.4f\n%s%12.4f", "   p = ", p, "   q = ", q);
else
  fprintf (f12, "\n%s", " no hay recta de regresion");
}

/* ------------------------------------------------------------------ */
/* Funcion que calcula la recta de regresion */

void regres (float x[], float y[], int m, float *p, float *q, int *indic) {

/* Variables locales */

int i;
float sumx2, sumx, sumxy, sumy, d;

/* Calculo de las sumas sumx2, sumx, sumxy, sumy */

sumx2 = 0;
sumx = 0;
sumxy = 0;
sumy = 0;
for (i=0; i<m; i++) {
  sumx2+= pow(x[i],2);
  sumx+= x[i];
  sumxy+= x[i]*y[i];
  sumy+= y[i]; }

/* Calculo de p, q  */

d = m*sumx2 - pow(sumx,2);
if (d == 0)
  *indic = 1;
else {
  *indic = 0;
  *p = (m*sumxy - sumx*sumy) / d;
  *q = (sumy - *p*sumx) / m; }
}

