PROGRAM practica2_angel_gil
IMPLICIT NONE    
INTEGER i,j,a(9,2),m,k,b,c,d
INTEGER, ALLOCATABLE :: x(:)

!Abrimos el fichero de datos y el de resultados.   

OPEN (13, FILE='Practica2.DAT')
OPEN (14, FILE='Practica2.RESULT')

!Escribimos la primera fila del fichero de salida.       

WRITE (14,'(2X,A,1X,A,3X,A,2X,A,25X,A,24X,A)') 'Caso','|','x','|','Factorizacion','|'
WRITE (14,'(2X,A)') '=====|======|==============================================================|'
  
!Leemos la tabla de datos como matriz.

DO i = 1, 9
  READ (13,*)  (a(i,j),j=1,2) !Cada fila tiene dos datos (nº de caso y n).                                                                                                                                          

  !Escribimos el caso en el fichero de salida.
  
  WRITE (14, 9000, ADVANCE='NO') a(i,1), a(i,2)
  9000 FORMAT (5X,I1,1X,'|',1X,I4,1X,'|')
  
  !calculamos m.  
  
  m = 0
  k = 0
  DO
    k = (3**(m + 1) - 1) / 2
    IF (k > a(i,2)) EXIT
    m = m + 1
  ENDDO
  
  !Creamos un vector x para la factorización de n.
  
  j = m + 1 !La dimensión de x será m+1. 
  ALLOCATE (x(j))
  
  !Calculamos la factorización de n.

  Do b = 1, j
    c = mod (a(i,2), 3)
    d = (a(i,2) - c) / 3
    IF (c == 2) THEN
      a(i,2) = d + 1
      x(b) = -1
    ELSE
      a(i,2) = d
      x(b) = c
    ENDIF  
    
    !Escribimos la factorización en el fichero de salida.
    
    WRITE (14, '(I4,2X,A)', ADVANCE='NO') x(b),'|' 
  ENDDO
  DEALLOCATE(x)
  IF (i==9) EXIT !la última linea de la tabla será distinta.
  WRITE (14, '(/,2X,A)') '-----|------|------|------|------|------|------|------|------|------|------|'  
ENDDO

WRITE (14,'(/,2X,A)') '---------------------------------------------------------------------------'

ENDPROGRAM practica2_angel_gil