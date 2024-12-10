PROGRAM cuerpos
IMPLICIT NONE
REAL r, h, g, slat, stot, vol
REAL, PARAMETER:: pi=3.141592

! CILINDRO y CONO:
!  Variables de entrada:
!      r: radio de la base
!      h: altura
!  Variables de salida:
!      slat: superficie lateral
!      stot: superficie total
!      vol : volumen

WRITE (*,'(A)',ADVANCE='NO') ' radio de la base = '
READ*, r
WRITE (*,'(A)',ADVANCE='NO') ' altura = '
READ*, h

slat = 2.0*pi*r*h
stot = slat + 2.0*pi*r**2
vol = pi*r**2 * h
WRITE (*,*) ' CILINDRO'
WRITE (*,*) ' Superficie lateral = ', slat
WRITE (*,*) ' Superficie total   = ', stot
WRITE (*,*) ' Volumen      = ', vol

g = (h**2+r**2)**0.5
slat = pi*r*g
stot = slat + pi*r**2
vol = vol/3
WRITE (*,*)
WRITE (*,*) ' CONO'
WRITE (*,*) ' Superficie lateral = ', slat
WRITE (*,*) ' Superficie total   = ', stot
WRITE (*,*) ' Volumen      = ', vol

! ESFERA:
!  Variable de entrada:
!      r: radio
!  Variables de salida
!      stot: superficie total
!      vol : volumen

WRITE (*,'(/A)',ADVANCE='NO') ' radio de la esfera = '
READ*, r
stot = 4.0*pi*r**2
vol = 4.0/3.0*pi*r**3
PRINT*
WRITE (*,*) ' Superficie esferica = ', stot
WRITE (*,*) ' Volumen      = ', vol

ENDPROGRAM cuerpos