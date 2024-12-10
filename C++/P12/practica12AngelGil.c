/* Incluimos librerias para trabajar con ficheros y operar. */
#include <stdio.h>

/* Iniciamos el programa principal. */
main() {
  
  /* Definimos los punteros de los archivos de entrada y salida; los abrimos. */
  FILE *dat, *res;      /* "r" indica solo lectura, "w" solo escritura. */
  dat = fopen("practica12.DAT", "r"), res = fopen("practica12.RESULT", "w");
  
  /* Definimos las variables. */
  int i;
  float a, fa, b, fb, c, fc, p, q, m, s, t, u;
  
  /* Nos aseguramos de que no haya problemas de apertura. */
  if (dat == NULL || res == NULL) printf ("Error en la apertura del archivo \n");

  /* Comenzamos a redactar el fichero de salida. */
  fprintf(res,"PRACTICA  12: FUNCION DIRECTA-INVERSA\n              =======================\n\n"
             "                 =====          ===============================================\n"
			 "Numero de orden: | 44|  Alumno: | GIL ALAMO ANGEL, AMANDO                     |\n"
			 "                 =====          ===============================================\n\n"
			 "===============================================================================\n"
             "|Caso |    (a , fa)   |    (b , fb)   |    (c , fc)   |   s   |   t   |   u   |\n"
             "|=============================================================================|\n");
  
  /* Iniciamos el bucle principal, "i" distingue cada caso. */
  for (i = 1; i <= 9; i++) {
	  
	/* Leemos y asignamos los datos. */
    fscanf (dat, "%f %f %f %f %f %f", &a, &fa, &b , &fb, &c, &fc);
	
	/* Calculamos p, q, m. */
	p = a * (b - c) * (fb - fa);
	q = c * (a - b) * (fc - fb);
	m = (a - b) * (a - c) * (b - c);

	/* Calculamos s, t, u. */
	s = (m * fa + p * (b * c - a * b - a * c) / a + c * q) / m; 
	t = (a * p * (b + c) - c * q * (a + b)) / m; 
	u = a * b * c * (q - p) / m;

	/* Escribimos los resultados. */
	fprintf(res, "|  %1i  | (%4.3f,%4.3f) | (%4.3f,%4.3f) | (%4.3f,%4.3f) | %4.3f | %4.3f | %4.3f |"   
			     , i, a, fa, b, fb, c, fc, s, t, u);
	if (i == 9) { /* Distinguimos el ultimo caso para cerrar la tabla. */
		fprintf(res, "\n===============================================================================");
	}
	else {
      fprintf(res, "\n|-----------------------------------------------------------------------------|\n");
	}
  }
  
  /* Finalmente, cerramos los ficheros. */
  fclose(dat);
  fclose(res);
}