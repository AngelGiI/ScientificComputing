/* Incluimos librerias para trabajar con ficheros y operar. */
#include <stdio.h>
#include <math.h>

/* Iniciamos el programa principal. */
main() {
  
  /* Definimos los punteros de los archivos de entrada y salida; los abrimos. */
  FILE *dat, *res;      /* "r" indica solo lectura, "w" solo escritura. */
  dat = fopen("practica9.DAT", "r"), res = fopen("practica9.RESULT", "w");
  
  /* Definimos las variables principales:
  Enteras y constantes: 
    "m, n"           numero de filas (columnas)
    "k"              tamaño de la sumbatriz cuadrada
	
  Enteras:
    "i, j, r, s"     variables para recorrer bucles "for"
	"rmejor, smejor" nos indican en que fila (columna) se alcanza el mayor valor de f
	
  Reales:
    "a"              matriz en la que asignaremos los datos de entrada
	"L, U"           acumulan los valores de la submatriz inferior (superior) asociada en cada caso
    "f"              valor de la funcion resultante "L - U" para cada submatriz de cada caso
	"fmejor"         valor maximo de f
  */
  int const m=15, n=10, k=4;
  int i, j, r, s, rmejor, smejor;
  float a[15][10], L, U, f, fmejor; 
  
  /* Nos aseguramos de que no haya problemas de apertura. */
  if (dat == NULL || res == NULL) printf ("Error en la apertura del archivo \n");
  
  /* En este bucle leemos los datos y vamos asignandolos a la matriz "a". */
  for (i = 0; i < m; i++) {
	for (j = 0; j < n; j++) fscanf (dat, "%f", &a[i][j]);
  }
  
  /* Damos un valor inicial a las variables principales (si f siempre fuera 
  negativa devolveria 0, hemos comprobado previamente que no haya problema).*/
  fmejor = 0.0, f = 0.0, rmejor = 1, smejor = 1;

  /* Realizamos los calculos, este es el bucle principal del programa. */
  for (r = 0; r < m - (k - 1); r++) {  /* "r" y "s" recorren todas las submatrices posibles */
    for (s = 0; s < n - (k - 1); s++) {
		
	  L = U = 0.0;  /* Reiniciamos L y U en cada caso. */
	  
      for (i = r; i < r + k; i++) {   /* "i" y "j" recorren la submatriz de cada caso "r,s" */
        for (j = s; j < s + k; j++) { 
		
          if (i - r > j - s) L = L + a[i][j];  /* si el indice de la fila es mayor que el de la */
          if (i - r < j - s) U = U + a[i][j];  /* columna (¡en la submatriz!), actualizamos "L". */
        }									   /* El caso contrario es analogo. Si "i == j" estamos */
      }										   /* en la diagonal principa. */
	  
	  f = L - U;  /* Calculamos "f", la comparamos con "fmejor" y decidimos si actualizar o no. */
      if (f > fmejor) fmejor = f, rmejor = r + 1, smejor= s + 1;
	}
  }
  
  /* Escribimos los resultados en el fichero de salida. */
  fprintf (res, "\n       ======      ======             ===========");
  fprintf (res, "\n   r = | %2i |  s = | %2i |    f(A  ) = |%f|", rmejor, smejor, fmejor);
  fprintf (res, "\n       ======      ======       rs    ===========");
  
  /* Finalmente, cerramos los ficheros. */
  fclose(dat), fclose(res);
}