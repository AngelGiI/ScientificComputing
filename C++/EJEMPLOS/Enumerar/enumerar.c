/* ======================================================================
  ALGORITMO DE ENUMERACION EXPLICITA

  PROPOSITO: Resuelve un problema de programacion lineal entera con
             variables acotadas enumerando todas las soluciones

  PROBLEMA: opt  z = SUMA (c(j) * x(j), j=1..n)

            sujeto a:
                     SUMA (a(i,j)*x(j), j=1..n)  (<= | = | >=)  b(i)
                                                   para i=1..m

                     v(j) <= x(j) <= u(j);  x(j) entera;  para j=1..n

  ELEMENTOS DEL PROBLEMA:

    MA : maximo valor permitido para m
    NA : maximo valor permitido para n
    a, b, c, u, v, n, m : definicion del problema
    ibt[i] : TIPO DE RESTRICCION i=1..m
             0 : ==
             1 : <=
             2 : >=
    sol : solucion optima con valor z

  VARIABLES AUXILIARES:

    i, j, k : subindices
    nfac    : numero de soluciones factibles
    total   : numero de soluciones que satisfacen las cotas
    fdatos  : nombre del fichero de datos
    fresul  : nombre del fichero de resultados
    isem0   : semilla inicial del generador de numeros aleatorios
    isem    : semilla iterativa del generador de numeros aleatorios
    cont    : usada para decidir si se desea resolver el problema

  OPCIONES DEL PROGRAMA:

    id : TIPO DE DATOS
         0 : se leen de un fichero
         1 : se generan aleatoriamente (con restricciones .LE.)

    ir : SALIDA DE RESULTADOS
         1 : mostrar los resultados en pantalla
         2 : guardar los resultados en un fichero

    is : ESCRITURA DE LAS SOLUCIONES
         0 : no escribir las soluciones intermedias
         1 : escribir todas las soluciones factibles
         2 : escribir cada mejor solucion encontrada

    iz : FUNCION OBJETIVO
         1 : minimizar
        -1 : maximizar

  FUNCIONES LLAMADAS:
    iranf : generador de numeros enteros uniformes
    todas : algoritmo de enumeracion explicita

 ======================================================================*/

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#define MA 21    /* el subindice 0 no se utilizara */
#define NA 11    /* el subindice 0 no se utilizara */

/* Variables externas */

int a[MA][NA], b[MA], ibt[MA], c[NA], u[NA], v[NA], sol[NA];
int n, m, ir, is, iz, z, nfac;
int isem;
void todas ();
int siguiente (int, int[], int[], int[]);
double ranf ();
int iranf (int, int);
FILE *origen, *salida;

void main () {
 extern int a[MA][NA], b[MA], ibt[MA], c[NA], u[NA], v[NA], sol[NA];
 extern int n, m, ir, is, iz, nfac;
 extern int isem;
 int id, i, j, k, isem0;
 double total;
 char fdatos[16], fresul[16], cont;
 extern FILE *origen, *salida;

/* Peticion de datos */

 printf ("%s\n%s\n%s\n%s", "TIPO DE DATOS", "0: Se leen de un fichero",
     "1: Se generan aleatoriamente", "   opcion: "); scanf ("%d", &id);

 if (id == 0) {  /* lectura de datos de un fichero */
   printf ("\n   Nombre del fichero de datos: ");
   scanf ("%s", fdatos); origen = fopen(fdatos, "r");

   fscanf (origen, "%i%i%i", &n, &m, &iz);
   for (i=1; i<=m; i++) {
     for (j=1; j<=n; j++) fscanf (origen, "%i", &a[i][j]);
     fscanf (origen, "%i%i", &b[i], &ibt[i]);
   }
   for (j=1; j<=n; j++) fscanf (origen, "%i", &c[j]);
   for (j=1; j<=n; j++) fscanf (origen, "%i", &v[j]);
   for (j=1; j<=n; j++) fscanf (origen, "%i", &u[j]);
   fclose (origen);
 }
 else { /* generacion de datos aleatorios */
   printf ("\nn (<=%2i) = ", NA-1); scanf ("%i", &n);
   if (n >= NA) { printf ("El valor de n no es valido"); return; }

   printf ("m (<=%2i) = ", MA-1); scanf ("%i", &m);
   if (m >= MA) { printf ("El valor de m no es valido"); return; }

   printf ("iz (1:min, -1:max) = "); scanf ("%i", &iz);
   if (abs(iz) != 1) { printf ("El valor de iz no es valido"); return; }

   printf ("semilla(INTEGER) = "); scanf ("%i", &isem0); isem = isem0;

   k = m + n;
   for (i=1; i<=m; i++) {
     ibt[i] = 1;
     b[i] = iranf(0, k);  /*  b(i)~UI(0,k) */
     for (j=1; j<=n; j++) a[i][j] = iranf(-k, k);  /* a(i,j)~UI(-k,k) */
   }
   for (j=1; j<=n; j++) {
     c[j] = iranf(-k, k);     /* c(j)~UI(-k,k)  */
     v[j] = 0;
     u[j] = iranf(1, n/2);    /* u(j)~UI(1,n/2) */
   }
 } /* El problema ya esta definido */

/* Si hay muchas soluciones que cumplen las cotas el tiempo de calculo
   puede ser grande. El mayor entero valido es 2**31-1=2147483647 */

 total = 1;
 for (j=1; j<=n; j++) total = total*(u[j]-v[j]+1.0);
 printf ("\nHay %g soluciones que cumplen las cotas\n", total);

 printf ("Continuar (S/N) ? ");
 etiq: scanf ("%c", &cont);
 if (cont!='s' && cont!='S' && cont!='n' && cont!='N') goto etiq;
 if (cont!='s' && cont!='S') {
   printf ("\nPROBLEMA NO RESUELTO\n"); return; }

/* Escritura de soluciones  */

 printf ("\n%s\n%s\n%s\n%s\n%s", "ESCRITURA DE SOLUCIONES",
     "0: ninguna", "1: las factibles", "2: solo las mejores",
     "   opcion = "); scanf ("%i", &is);

/* Salida de resultados  */

 printf ("\n%s\n%s\n%s\n%s", "RESULTADOS",
     "1: pantalla", "2: fichero", "   opcion: "); scanf ("%d", &ir);

 if (ir == 2) {  /* resultados en un fichero */
   printf ("\n   nombre del fichero de salida: ");
   scanf ("%s", fresul); salida = fopen(fresul, "w");
   if (id == 1) { /* escritura del problema  */
     fprintf (salida, "isem0 = %10i\nn = %2i\nm = %2i\niz = %2i\n",
              isem0, n, m, iz);
     fprintf (salida, "\nfuncion objetivo c = ");
     for (j=1; j<=n; j++) fprintf (salida,"%d ", c[j]);
     for (i=1; i<=m; i++) {
       fprintf (salida, "\nb(%2i) =%5i; a(%2i,:) = ", i, b[i], i);
       for (j=1; j<=n; j++) fprintf (salida, "%d ", a[i][j]);
      }
     fprintf (salida, "\nCotas superiores\n");
     for (j=1; j<=n; j++) fprintf (salida, "%d ", u[j]);
     fprintf (salida, "\n");
   }
 }
 else {
   if (id == 1) { /* escritura del problema  */
     printf ("\nescritura de datos\n");
     printf ("\nisem0 = %10i\nn = %2i\nm = %2i\niz = %2i\n",
             isem0, n, m, iz);
     printf ("\nfuncion objetivo c = ");
     for (j=1; j<=n; j++) printf ("%d ", c[j]);
     for (i=1; i<=m; i++) {
       printf ("\nb(%2i) =%5i; a(%2i,:) =", i, b[i], i);
       for (j=1; j<=n; j++) printf ("%d ", a[i][j]);
       printf ("\n");
     }
     printf ("\nCotas superiores\n");
     for (j=1; j<=n; j++) printf ("%d ", u[j]);
     printf ("\n");
   }
 }

/* Solucion del problema */

 todas();

 if (ir == 2) { /* escritura en fichero */
   if (nfac == 0) { /* problema infactible */
     fprintf (salida, "\n%s%16.9g\n%s\n",
              "Numero de soluciones entre las cotas = ", total,
              "El problema NO tiene solucion factible");
   }
   else { /* solucion optima encontrada */
     fprintf (salida, "\n\n%s%16.9g\n\n%s%10i\n\n%s%10i\n\n%s",
              "numero de soluciones entre las cotas = ", total,
              "numero de soluciones factibles = ", nfac,
              "valor optimo = ", z,
              "solucion optima = ");
     for (j=1; j<=n; j++) fprintf (salida, "%d ", sol[j]);
     fclose (salida);
   }
 }
 else { /* escritura en pantalla */
   if (nfac == 0) { /* problema infactible */
     printf ("\n%s%16.9g\n%s\n",
             "Numero de soluciones entre las cotas = ", total,
             "El problema NO tiene solucion factible");
   }
   else { /* solucion optima encontrada */
     printf ("\n\n%s%16.9g\n\n%s%10i\n\n%s%10i\n\n%s",
             "numero de soluciones entre las cotas = ", total,
             "numero de soluciones factibles = ", nfac,
             "valor optimo = ", z,
             "solucion optima = ");
     for (j=1; j<=n; j++) printf ("%d ", sol[j]);
   }
 }
printf ("\n\n");
}

/* =====================================================================
  FUNCION todas

  PROPOSITO: Enumera todas las soluciones enteras que satisfacen las
             cotas, comprueba si ademas cumplen las otras restricciones
             y encuentra una solucion optima, si existe

  ARGUMENTOS DE ENTRADA:
     PUNTERO A FICHERO: Puntero al fichero de salida

  VARIABLES EXTERNAS:
     PARAMETRO: MA <=> dimension de filas de la matriz a
     PARAMETRO: NA <=> dimension de columnas de la matriz a
     INT: n, m <=> dimensiones del problema
     INT: ir   <=> opcion de salida de resultados
     INT: is   <=> opcion de escritura de soluciones
     INT: iz   <=> opcion de minimizar/maximizar
     INT: z    <=> valor optimo del problema (si nfac>0)
     INT: nfac <=> numero de soluciones factibles
     INT: a[MA,NA], b[MA], ibt[MA], c[NA], v[NA], u[NA] <=> problema
     INT: sol[NA] <=> solucion optima

  VARIABLES LOCALES:
    i, j  : subindices
    infto : infinito
    sum   : valor de la funcion objetivo
    mejor : 1 si la solucion es la mejor encontrada, 0 en otro caso
    x[NA] : solucion en estudio
    fin   : 1 si en entrada x(j) = mayor(j) para todo j, 0 en otro caso

========================================================================*/

void todas () {
  extern int a[MA][NA], b[MA], ibt[MA], c[NA], u[NA], v[NA], sol[NA];
  extern int n, m, ir, is, iz, z, nfac;
  extern FILE *salida;

  int i, j, infto, suma, mejor, x[NA], fin;

  nfac = 0;
  infto = 2147483647;
  z = iz*infto;
  for (i=1; i<=n; i++) x[i] = v[i]; /* primera solucion a probar */

  do { /* analisis de las soluciones */
    mejor = 0;

/* Comprobar si x es factible */

    for (i=1; i<=m; i++) {
      suma = 0;
      for (j=1; j<=n; j++) suma += a[i][j]*x[j];
      if ((ibt[i]==0 && suma!=b[i] ) ||
          (ibt[i]==1 && suma>b[i] ) ||
          (ibt[i]==2 && suma<b[i] )) goto etiq2; }

/* La solucion x es factible. Se evalua la funcion objetivo */

    nfac++; /* nueva solucion factible  */
    suma = 0;
    for (j=1; j<=n; j++) suma += c[j]*x[j];

/* Comprobar si x es la mejor solucion hasta el momento. Si lo es, se
   actualiza z, x se guarda en sol y se escribe segun la opcion is. */

    if (iz*suma < iz*z) {
      mejor = 1; /* mejor solucion factible hasta el momento */
      z = suma;
      for (j=1; j<=n; j++) sol[j] = x[j];
      if (is >= 1) {
        if (ir == 2) fprintf (salida, "\n\n*** MEJOR SOLUCION");
        else printf ("\n\n*** MEJOR SOLUCION");  }
    }
    if ((is == 1) || (is==2 && mejor)) {
      if (ir == 2) {
        fprintf (salida, "\nz=%4i,  x= ", suma);
        for (j=1; j<=n; j++) fprintf (salida, "%4d ", x[j]); }
      else {
        printf ("\nz=%4i, x= ", suma);
        for (j=1; j<=n; j++) printf ("%d ", x[j]); }
    }

/* Siguiente vector a x en la seudobase [v,u]  */

    etiq2:
    fin = siguiente (n, v, u, x);
    if (fin) return; /* Se han examinado todas las soluciones */
  } while(1);

}

/* =====================================================================
  FUNCION siguiente

  PROPOSITO: Encuentra el siguiente vector entero en una seudobase

  ARGUMENTOS DE ENTRADA:
     INT: n <=> dimension del problema
     INT: menor[n], mayor[n] <=> cotas de las variables
     INT: x[n]
          En entrada:  menor[j] <= x[j] <= mayor[j]
          En salida:   el siguiente vector al de entrada.
                       Si en entrada es x[j] = mayor[j] para todo j
                         en salida sera x[j] = menor[j] para todo j

  VALOR DEVUELTO POR LA FUNCION:
     INT: fin
          (1) si en entrada x(j) = mayor(j) para todo j
          (0) en otro caso
========================================================================*/

int siguiente (int n, int menor[NA], int mayor[NA], int x[NA]) {

  int j, fin;

  fin = 1;
  for (j=n; j>=1; j--) {
    if (x[j] == mayor[j]) x[j] = menor[j];
    else {x[j]++ ; fin = 0 ; return (fin);}
  }
  return(fin);
}

/* =====================================================================
  FUNCTION ranf

  PROPOSITO: Genera numeros aleatorios uniformes en (0,1)
             Adaptacion de: ran0 (NUMERICAL RECIPES)

  VARIABLES EXTERNAS:
     INT: isem  <=> semilla (>0)

  VALOR DEVUELTO POR LA FUNCION:
     DOUBLE: ranf <=> numero aleatorio en (0,1)
========================================================================*/

double ranf() {

  extern int isem;
  int ia=16807, im=2147483647, iq=127773, ir=2836, k;
  double ranf;

  k = isem / iq;
  isem = ia*(isem-k*iq) - ir*k;
  if (isem < 0) isem += im;
  ranf = (double) isem/im;
  return (ranf);
}

/* =====================================================================
  FUNCTION iranf

  PROPOSITO: Genera numeros aleatorios uniformes enteros en (a, b)

  ARGUMENTOS DE ENTRADA:
     INT: a  <=> extremo inferior
     INT: b  <=> extremo superior

  VARIABLES EXTERNAS:
     INTEGER: isem  <=> semilla (>0)

  FUNCIONES LLAMADAS:
     ranf : generador de un numeros aleatorio en (0,1)

  VALOR DEVUELTO POR LA FUNCION:
     INTEGER: iranf <=> numero entero aleatorio en [a, b]
========================================================================*/

int iranf (int a, int b) {
  extern int isem;
  int iranf;

  iranf = a + (double) (b-a+1)*ranf();
  return (iranf);
}

