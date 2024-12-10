/* Ejemplo Ej1-4 de Curso Basico de Fortran */

#include <stdio.h>
#include <math.h>
main () {

/*  Declaracion de variables  */

int n, i;
float x[100];       /* con x[99] no salen resultados en pantalla */
float suma, media, varianza;

/*  Definicion de los 100 primeros numeros impares  */

n = 100;
for (i=0; i<n; i++) x[i] = 2*i + 1;

/*  Calculo de la suma, media y varianza  */

suma = 0;             /* Iniciacion de suma   */
for (i=0; i<n; i++) suma += x[i];

media = suma / n;

varianza = 0;         /* Iniciacion de varianza  */
for (i=0; i<n; i++) varianza += pow(x[i]-media,2);

varianza = varianza / n;

/*  Escritura de resultados  */

printf ("%s%f", "suma = ", suma);
printf ("\n%s%f", "media = ", media);
printf ("\n%s%f\n", "varianza = ", varianza);
}

