/* Ejemplo Ej1-5 de Curso Basico de Fortran */

#include <stdio.h>
#include <math.h>
main () {

int n, i;
float x[100];
float suma, media, varianza;

/* Lectura por teclado de los numeros x(i)
   Para terminar poner 9999  */

i = -1;
do {                                            /* Bucle do-while */
  i++;
  printf ("%s%d\n", "i = ", i);
  scanf ("%f", &x[i]); }  while (x[i] != 9999);

n = i;

/*  Calculo de la suma, media y varianza  */

suma = 0;
for (i=0; i<n; i++) suma += x[i];
media = suma / n;

varianza = 0;
for (i=0; i<n; i++) varianza += pow(x[i]-media,2);
varianza = varianza / n;

/*  Escritura de resultados  */

printf ("%5.0s%s%4d%s", " ", "Se han leido ", n, " numeros");
printf ("\n\n%2.0s%s%10.4f%3.0s%s%10.4f%3.0s%s%10.4f\n", " ", "suma = ",
        suma, " ", "media = ", media, " ", "varianza = ", varianza);
}

