/* Estructura de control switch */

#include <stdio.h>
main () {
  int indice;
  char car;

  printf ("Introducir un caracter = ") ; scanf ("%c", &car);
  switch (car) {
    case 'a': case 'e': case 'i': case 'o': case 'u':
      printf ("\n%s%c", "Vocal minuscula: ", car) ; break;

    case 'A': case 'E': case 'I': case 'O': case 'U':
      printf ("\n%s%c", "Vocal mayuscula: ", car) ; break;

    case 'b': case 'c':  case 'd':  case 'f':  case 'g':  case 'h':
    case 'j': case 'k':  case 'l':  case 'm':  case 'n':  case 'ñ':
    case 'p': case 'q':  case 'r':  case 's':  case 't':  case 'v':
    case 'w': case 'x':  case 'y':  case 'z':
      printf ("\n%s%c", "Consonante minuscula: ", car) ; break;

    case 'B': case 'C':  case 'D':  case 'F':  case 'G':  case 'H':
    case 'J': case 'K':  case 'L':  case 'M':  case 'N':  case 'Ñ':
    case 'P': case 'Q':  case 'R':  case 'S':  case 'T':  case 'V':
    case 'W': case 'X':  case 'Y':  case 'Z':
      printf ("\n%s%c", "Consonante mayuscula: ", car) ; break;

    case '0': case '1': case '2': case '3': case '4':
    case '5': case '6': case '7': case '8': case '9':
      printf ("\n%s%c", "Cifra del 0 al 9: ", car) ; break;

    default:
      printf ("\n%c%s", car, " no es ni letra ni numero");
  }

  printf ("\n\nIntroducir un numero = ") ; scanf ("%d", &indice);
  switch (indice) {
    case 2: case 3: case 5: case 7: case 11: case 13: case 17: case 19:
      printf ("\n%s%d", "Numero primo menor que 20: ", indice) ; break;

    case 20: case 22: case 24: case 26: case 28:
      printf ("\n%s%d", "Numero par entre 20 y 28: ", indice) ; break;

    default:
      printf ("\n%s%d", "Otro numero: ", indice);
  }
  printf ("\n");
}

