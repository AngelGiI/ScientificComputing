/* Incluimos librerias para trabajar con ficheros, matrices y operar. */
#include <stdio.h>
#include <math.h>
#include <stdlib.h>

/* Iniciamos el programa principal. */
main() {

   /* Definimos los punteros de los archivos de entrada y salida; los abrimos. */
  FILE *dat, *res;      /* "r" indica solo lectura, "w" solo escritura. */
  dat = fopen("practica10.DAT", "r"), res = fopen("practica10.RESULT", "w");

  /* Definimos las variables principales:
  Doble precision y constantes: 
    "c, eps"      utilizadas en el caso 4 (para la creacion de la lista)
	
  Enteras:
    "n"           numero de elementos en nuestra candidata a permutacion
    "i, j, k"     variables para recorrer bucles "for"
	"es_permuta"  toma los valores 1 o 2, indica si el candidato es permutacion
	              (podria ser un booleano pero cumple su funcion)
	"no_pert"     contador de numeros que no pertenecen a la permutacion
	"total_repe"  contador de numeros que aparecen mas de una vez
	"total_falta" contador de numeros que faltan en la permutacion
  
  Vectores (Enteros):
	"p"           array en el que escribiremos el candidato a permutacion (datos)
	"v"           lo utilizaremos para comparar con p (tendra los enteros del 1 a n) 
	"repe"        contendra el numero de veces que aparece cada numero (del 1 al n)
	
  Doble precision:
    "t"           utilizado en el caso 4 (para la creacion de la lista)
  */
  double const c = 1.253514, eps = 1.19848e-5;
  int n, i, j, k, es_permuta, no_pert, total_repe, total_falta, p[1200], v[1200], repe[1200];
  double t;
  
  /* Nos aseguramos de que no haya problemas de apertura. */
  if (dat == NULL || res == NULL) printf ("Error en la apertura del archivo \n");

  /* Iniciamos el bucle principal, "i" distingue cada caso. */
  for (i = 0; i < 4; i++) {
	  
	/* Leemos y asignamos "n", escribimos el numero de caso. */
	fscanf (dat, "%i", &n), fprintf(res, "Caso %1i: n =%4i\n\nConjunto:",i+1,n);
	
	/* (Re)iniciamos el contador de numeros no pertenecientes, repetidos, 
	numeros que faltan y si es permutacion. */
	no_pert = 0, total_repe = 0, total_falta = 0, es_permuta = 1;
	
	/* Comenzamos los calculos: */
	for (j = 0; j < n; j++) {                    /* El bucle se recorre n veces. */
	
	  v[j] = j + 1;                              /* vamos construyendo "v" (numeros en orden creciente). */
	  
	  if (j % 10 == 0) fprintf(res, "\n     ");  /* Escribimos los candidatos en filas de 10 columnas. */
	  
	  if (i == 3)  {							 /* El ultimo caso es distinto a los anteriores.*/
	  
	    t = (j + 1) / (eps + n);                 /* "t" se va actualizando en cada iteracion. */                                
        p[j] = 1 + floor (n * ((c - 1) * (2 * t - 3) * pow(t,2) + c * t)); /* vamos rellenando "p". */
		fprintf(res, "%3i ",p[j]);				 /* Escribimos "p". */
		
	  }
	  else {									 /* Leemos los casos 1 al 3 (0 a 2 en nuestro bucle) */
	    fscanf (dat, "%i", &p[j]);				 /* y los escribimos con un formato segun el caso. */
	  if (i == 0) fprintf(res, "%2i ",p[j]);
	  if (i == 1) fprintf(res, "%3i ",p[j]);
	  if (i == 2) fprintf(res, "%4i ",p[j]);
      }
	  
	  if (p[j] > n) {							 /* vamos acumulando los valores mayores de lo debido */
		no_pert = no_pert + 1;					 /* (de haberlos), si es asi el candidato no sera permutacion. */
		es_permuta = 2;
	  }
	}
	
	/* Terminamos los calculos: */
	for (j = 0; j < n; j++) {					 
		repe[j] = 0;						 /* (Re)iniciamos el vector que contara cuantas veces aparece cada numero. */
		for (k = 0; k < n; k++) {
          if (p[k] == v[j]) repe[j] = repe[j] + 1; /* por cada "j" se recorren todos los valores de "p", comparandolos */
												   /* con "v[j] = j + 1", contando cuantas veces aparece "j + 1" */
                                                   /* y almacenando ese numero en "repe[j]". */
		}
		if (repe[j] == 0) {						   /* Si "repe[j]=0", significa que el candidato a permutacion no */
		  total_falta = total_falta + 1;		   /* contiene el numero "j+1". */
		  es_permuta = 2;
		}
		if (repe[j] > 1) {						   /* Si "repe[j]>1", significa "j+1" esta repetido. */
		  total_repe = total_repe + 1;
		  es_permuta = 2;
		}
	}
	
	/* Si ningun numero se repite, ni falta y no hay alguno que no pertenezca, "es_permuta" seguira siendo 1,
	cumpliendo que es permutacion. Si alguna de las condiciones no se cumple, valdra 2. */
	if (es_permuta == 1) fprintf(res, "\n\nEs permutacion:   SI");
	if (es_permuta == 2) fprintf(res, "\n\nEs permutacion:   NO");
	
	/* Escribimos en el fichero de salida los valores calculados anteriormente. */
	fprintf(res, "\n\n   FALTAN:      %4i\n",total_falta);
	fprintf(res, "   REPETIDOS:   %4i\n",total_repe);
	fprintf(res, "   NO PERTENECEN: %2i\n\n",no_pert);
	
	/* Realizamos los tres ultimos bucles, recorriendo el vector "repe[j]" y escribiendo donde corresponda
	segun repe[j] sea 0 (falta "j+1"), mayor que 1 (se repite) y en caso de que se repita, el numero de veces
	que lo hace (que será el valor de "repe[j]"). */
	
	fprintf(res, "Elementos que faltan:");
	for (j = 0; j < n; j++) {
	  if (repe[j] == 0) {
	    if (i == 0) fprintf(res, " %2i", v[j]);  /* Distinto formato de escritura segun el caso. */
		if (i == 2) fprintf(res, " %4i", v[j]);
		else {
		  fprintf(res, " %3i", v[j]);
		}
	  }
	}

	fprintf(res, "\n\nElementos repetidos :");
	for (j = 0; j < n; j++) {
	  if (repe[j] > 1) {
	    if (i == 0) fprintf(res, " %2i", v[j]);
		if (i == 2) fprintf(res, " %4i", v[j]);
		else {
		  fprintf(res, " %3i", v[j]);
		}
	  }
	}
	
	fprintf(res, "\nNumero de veces     :");
	for (j = 0; j < n; j++) {
	  if (repe[j] > 1) {
	    if (i == 0) fprintf(res, " %2i", repe[j]);
		if (i == 2) fprintf(res, " %4i", repe[j]);
		else {
		  fprintf(res, " %3i", repe[j]);
		}
	  }
	}
	
	/* Escribimos un separador al final del caso. */
	fprintf(res, "\n--------------------------------------------------------------------------\n");
  }

  /* Finalmente, cerramos los ficheros. */
  fclose(dat);
  fclose(res);
}