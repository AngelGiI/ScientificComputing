PROGRAM meteor
IMPLICIT NONE

! Este programa genera ficheros con datos simulados de las variables
!    temp  : temperatura
!    vel   : velocidad del viento
!    humed : humedad relativa
!    pres  : presion atmosferica

! Descripcion de variables:
!    maxlug : maximo numero de lugares admitidos
!    nlug   : numero de lugares considerados
!    lugar(nlug) : nombres de los lugares
!    nyear1 : año inicial
!    nyear2 : año final
!    ndias  : numero de dias de un mes
!    il : indice de lugar
!    ia : indice de año
!    im : indice de mes
!    id : indice de dia
!    ih : indice de hora
!    isem : semilla inicial para el generador de numeros aleatorios

! Nombres de los ficheros generados: DATmmaa.lug
! Cada fichero tiene un registro con datos por cada dia y hora

! Simulacion de datos:
! Sea tmax = 35 -(im-6.5)**2
!   si 0 <= ih <= 5   temp = tmax-5 - ih + u1               u1:U(-4,4)
!   si 6 <= ih <= 16  temp = tmax-10 + (10/11)*(ih-5) + u1  u1:U(-4,4)
!   si 17 <= ih <= 23 temp = tmax - (4/7)*(ih-16) + u1      u1:U(-4,4)
! vel   = 88 - 1.6*(temp+13) + u2                           u2:U(-8,8)
! humed = 60 -0.8*(temp+13)*u3 + 0.4*vel*u4                 u3,u4:U(0,1)
! pres  = 680 + 0.9*(temp+5) + u5                           u5:U(0,4)

INTEGER, PARAMETER:: maxlug=3
INTEGER nlug, nyear1, nyear2, ndias, i, il, ia, im, id, ih
INTEGER isem(1)
REAL u(5), tmax, temp, vel, humed, pres
CHARACTER(LEN=20) lugar(maxlug), fent, nomfile
CHARACTER(LEN=2) mm, aa, lug*3

WRITE (*,8000,ADVANCE='NO')
8000 FORMAT (/1X,'Fichero de nombres y dimensiones = ')
READ (*,'(A)') fent
OPEN (3, FILE=fent)
READ (3,'(3I5)') nlug, nyear1, nyear2
READ (3,'(A)') (lugar(i),i=1,nlug)

WRITE (*,8010,ADVANCE='NO')
8010 FORMAT (/1X,'Semilla inicial = ')
READ*, isem
CALL RANDOM_SEED (PUT=isem)

DO il = 1, nlug
  lug = lugar(il)(:3)
  DO ia = nyear1, nyear2
    WRITE (aa,'(I2.2)') MOD(ia,100)

    DO im = 1, 12
      WRITE (mm,'(I2.2)') im
      nomfile = 'DAT' // mm // aa // '.' // lug
      PRINT*, nomfile
      OPEN (4, FILE=nomfile)

      SELECT CASE (im)
        CASE (1,3,5,7,8,10,12)
          ndias = 31
        CASE (4,6,9,11)
          ndias = 30
        CASE (2)
          ndias = 28
          IF (MOD(ia,4) == 0) THEN
            ndias = 29
            IF (MOD(ia,100)==0 .AND. MOD(ia,400)/=0) ndias=28
          ENDIF
      ENDSELECT

      tmax = 35.0 - (im-6.5)**2

      DO id = 1, ndias
        DO ih = 0, 23
          CALL RANDOM_NUMBER (u)
          SELECT CASE (ih)
            CASE (0:5)
              temp = tmax-5 - ih + (-4.0+8.0*u(1))
            CASE (6:16)
              temp = tmax-10 + 10.0/11.0*(ih-5) + (-4.0+8.0*u(1))
            CASE (17:23)
              temp = tmax - 4.0/7.0*(ih-16) + (-4.0+8.0*u(1))
          ENDSELECT
          vel = 88.0 -1.6*(temp+13) + (-8.0+16*u(2)) 
          humed = 60.0 -0.8*(temp+13)*u(3) + 0.4*vel*u(4)
          pres = 680.0 + 0.9*(temp+5) + 4.0*u(5)
          WRITE (4,'(2I3,4F8.1)') id, ih, temp, vel, humed, pres
        ENDDO    ! ih
      ENDDO   ! id
      CLOSE (4)

    ENDDO   ! im
  ENDDO   ! ia
ENDDO   ! il

ENDPROGRAM meteor