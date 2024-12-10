! ======================================================================
! Calculo y escritura (opcional) de vectores

! Resultados obtenidos para n=15
! VISTA: Windows Vista Home Premium 32-bit Intel 2 Quad Q2800 2.33 Ghz,
!        4Gb DDR2-SDRAM 800Mhz
! WIN-7: Windows 7 Prof. 64-bit Intel i5-2300 CPU 2.8Ghz, 4 procesadores,
!        8Gb RAM
! WIN-10F: Windows 10 Prof. 64-bit Intel i5-6500 CPU 3.2Ghz
!        16Gb RAM. Compilador FTN95 V8.05
! WIN-10G: Windows 10 Prof. 64-bit Intel i5-6500 CPU 3.2Ghz
!        16Gb RAM. Compilador g95

! opcion    VISTA    WIN-7   WIN-10F  WIN-10G     bytes del
!    0      0.296    0.172     0.109    0.156      fichero
!    1     20.202   13.962     9.125   16.984   674.398.629
!    2      7.753    4.555     2.781    7.562   889.632.234
!    3    104.053   45.100    36.906   16.578   674.398.629
!    4     83.570   30.545    29.391    7.344   860.934.420
! ----------------------------------------------------------------------

PROGRAM seubobase
IMPLICIT NONE

INTEGER, PARAMETER:: nmax=19
INTEGER  n, icont, isal, lon, menor(nmax), mayor(nmax), x(nmax)
DOUBLE PRECISION t0, t1
LOGICAL fin
INTEGER, PARAMETER:: nsal=11
CHARACTER(LEN=30) fsal

WRITE (*,'(A,I0,A)',ADVANCE='NO') 'n (<=', nmax, ') = ' ; READ*, n
WRITE (*,'(A)',ADVANCE='NO') 'Escritura de vectores:',                  &
         '   0: no se escriben',                                        &
         '   1: se escriben (secuencial, formateado)',                  &
         '   2: se escriben (secuencial, no formateado)',               &
         '   3: se escriben (directo, formateado)',                     &
         '   4: se escriben (directo, no formateado)',                  &
         '      opcion = '
READ*, isal
IF (isal >= 1) THEN
  WRITE (*,'(/A)',ADVANCE='NO') 'Fichero de escritura = '
  READ (*,'(A)') fsal
ENDIF

SELECT CASE (isal)
CASE (1)
  OPEN (UNIT=nsal, STATUS='REPLACE', ACCESS='SEQUENTIAL',               &
        FORM='FORMATTED', FILE=fsal)
CASE (2)
  OPEN (UNIT=nsal, STATUS='REPLACE', ACCESS='SEQUENTIAL',               &
        FORM='UNFORMATTED', FILE=fsal)
CASE (3)
  OPEN (UNIT=nsal, STATUS='REPLACE', ACCESS='DIRECT', RECL=3*n,         &
        FORM='FORMATTED', FILE=fsal)
CASE (4)
  INQUIRE (IOLENGTH=lon) x(1:n)
  OPEN (UNIT=nsal, STATUS='REPLACE', ACCESS='DIRECT', RECL=lon,         &
        FORM='UNFORMATTED', FILE=fsal)
ENDSELECT

CALL CPU_TIME (t0)
menor(1:n) = 0
mayor(1:n) = 6
menor(2) = 0
mayor(2) = 8
icont = 1
x(1:n) = menor(1:n)

DO
  SELECT CASE (isal)
  CASE (1)
    WRITE (nsal,'(19I3)') x(1:n)
  CASE (2)
    WRITE (nsal) x(1:n)
  CASE (3)
    WRITE (nsal,REC=icont,FMT='(19I3)') x(1:n)
  CASE (4)
    WRITE (nsal,REC=icont) x(1:n)
  ENDSELECT
  CALL xmas1 (n, menor, mayor, x, fin)
  IF (fin) EXIT
  icont = icont + 1
ENDDO

CALL CPU_TIME (t1)
WRITE (*,'(A,I10,3X,A,F10.3)') 'icont=', icont, 'tiempo (sg.)=', t1-t0

ENDPROGRAM seubobase

! ======================================================================
! SUBROUTINE xmas1

! PROPOSITO: Encuentra el siguiente vector entero en una seudobase

! ARGUMENTOS DE ENTRADA
!    INTEGER:: n <=> dimension de la seudobase (cantidad de cifras)
!    INTEGER:: menor(n), mayor(n) <=> cotas de las cifras

! ARGUMENTOS DE ENTRADA/SALIDA
!    INTEGER:: x(n)
!              En entrada: debe ser menor(j) <= x(j) <= mayor(j)
!              En salida:  el siguiente vector al de entrada.
!                          Si en entrada x(j) = mayor(j) para todo j
!                             en salida sera x(j) = menor(j) para todo j

! ARGUMENTOS DE SALIDA
!    LOGICAL:: fin = .true. si en entrada x(j) = mayor(j) para todo j
!              fin = .false. en otro caso

! Observacion.- No se comprueba si el vector de entrada es valido
! ======================================================================

SUBROUTINE xmas1 (n, menor, mayor, x, fin)
IMPLICIT NONE

! Argumentos

INTEGER, INTENT(IN):: n, menor(*), mayor(*)
INTEGER, INTENT(INOUT):: x(*)
LOGICAL, INTENT(OUT):: fin

! Variables locales

INTEGER j

! ----------------------------
! Primera sentencia ejecutable

fin = .true.

DO j = n, 1, -1
  IF (x(j) == mayor(j)) THEN
    x(j) = menor(j)
  ELSE
    x(j) = x(j) + 2
    fin = .false.
    EXIT          ! ya esta construido el vector siguiente a x
  ENDIF
ENDDO

ENDSUBROUTINE xmas1