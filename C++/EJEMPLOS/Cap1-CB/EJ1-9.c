/* Ejemplo Ej1-9 de Curso Basico de Fortran */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int iecu;
#define MIN(a,b) ((a)<(b) ? (a) : (b))
#define MAX(a,b) ((a)>(b) ? (a) : (b))

double fun (double);
void bisec (double (*f) (double), double, double, double, double,
      int*, double*, double*, int*);

void main (void) {
extern int iecu;

int indice, niter;
double a, b, tolx, tolf, x, fx;

/* Descripcion de la convergencia alcanzada */

char estado[50];
struct casoconv {char *estado;} caso[]={
      "fa y fb tienen el mismo signo",
      "se ha alcanzado la precision deseada",
      "solo se ha alcanzado la precision en x",
      "solo se ha alcanzado la precision en f",
      "no se ha alcanzado la precision en x ni en f"};

/* Lectura del intervalo, tolerancias e iteraciones */

for (iecu=1; iecu<=2; iecu++) {

  printf ("\n%s%d", "Ecuacion ", iecu);
  printf ("\n%s", " Extremo a = "); scanf ("%lf",&a);
  printf ("%s", " Extremo b = ");  scanf ("%lf",&b);
  printf ("%s", " Tolerancia para x = "); scanf ("%lf",&tolx);
  printf ("%s", " Tolerancia para f = "); scanf ("%lf",&tolf);
  printf ("%s", " Iteraciones = "); scanf ("%d",&niter);

/* Ecuacion 1: En [0,1] hay solucion */
/* Ecuacion 2: En [4,8] hay solucion */

  bisec (fun, a, b, tolx, tolf, &niter, &x, &fx, &indice);

  if (indice == 0)
    printf ("\n%s\n", caso[0].estado);
  else
    printf ("\n%s%25.15lf\n%s%25.15lf\n%s\n%s%d\n", "x = ", x, "f = ",
            fx, caso[indice].estado, "Evaluaciones de f = ", niter);
  }
}

/* ---------------------------------------------------------------------
! PROPOSITO: Resolver la ecuacion f(x)=0 por el metodo de la biseccion

! FUNCIONES LLAMADAS:
!    f <=> ecuacion a resolver f(x)=0

!    La descripcion de f debe codificarse como sigue:

            double f (double x);

! ARGUMENTOS DE ENTRADA:
!    double a, b <=> extremos del intervalo
!    double tolx, tolf <=> tolerancias en x, f

! ARGUMENTOS DE SALIDA:
!    double x <=> valor estimado de la raiz
!    double fx <=> f(x)
!    int indice <=> situacion alcanzada
!        indice=0 : f(a) y f(b) tienen el mismo signo
!        indice=1 : se han alcanzado ambas tolerancias
!        indice=2 : solo se ha alcanzado la tolerancia en x
!        indice=3 : solo se ha alcanzado la tolerancia en f
!        indice=4 : no se ha alcanzado la tolerancia en x ni en f

! ARGUMENTOS DE ENTRADA/SALIDA:
!    int niter
!        En entrada: maximo numero de divisiones del intervalo
!        En salida : numero de evaluaciones de f realizadas
! ------------------------------------------------------------------- */

void bisec (double (*f) (double), double a, double b, double tolx,
       double tolf, int *niter, double *x, double *fx, int *indice) {

/* Variables locales */

int n;
double xx, x1, x2, f1, f2;

/* ----------------------------
 Primera sentencia ejecutable */

x1 = MIN(a,b) ; f1 = f(x1);
x2 = MAX(a,b) ; f2 = f(x2);
*niter = MAX(1,MIN(abs(*niter),50));

*indice = 0;
if (f1*f2 > 0) {   /* f(a) y f(b) tienen el mismo signo */
  *niter = 2; return; }

/* Se realizaran a lo sumo niter iteraciones */

for (n=1; n<=*niter; n++) {
  xx = x1 + (x2-x1)/2; *fx = f(xx);
  if (f1*(*fx) > 0)
    { x1 = xx ; f1 = *fx; }
  else
    { x2 = xx ; f2 = *fx; }
  if (x2-x1<tolx && fabs(*fx)<tolf)
    { *niter = 2 + n;
      *indice = 1;  break; }  /* se han alcanzado ambas tolerancias */
}

if (*indice == 0) { /* No se han alcanzado las dos tolerancias */
  *niter = 2 + *niter;
  if (x2-x1 < tolx)
    *indice = 2;   /* solo se ha alcanzado la tolerancia en x */
  else if (MIN(fabs(f1),fabs(f2)) < tolf)
    *indice = 3;   /* solo se ha alcanzado la tolerancia en f */
  else
    *indice = 4;   /* no se ha alcanzado la tolerancia en x ni en f */
}

/* Mejor punto obtenido */

if (fabs(f1) <= fabs(f2))
  { *x = x1 ; *fx = f1; }
else
  { *x = x2 ; *fx = f2; }
return;
}
/* ------------------------------------------------------------------ */
/* Ecuacion a resolver fun(x)=0  */

double fun (double x) {
double ff;
extern int iecu;

switch (iecu) {
case 1:
  ff = 1 + x*(-6+x*(15+x*(-24+x*(15+x*(-6+x))))) ;
  break;
case 2:
  ff = pow(x,4) + 2*pow(x,3) - 36*pow(x,2) - 2*x - 1;
}
return ff;
}

