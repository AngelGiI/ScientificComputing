COMMON a,b                    ! estas cinco sentencias son
COMMON //r,i,s,m              ! equivalentes a las dos sentencias:
COMMON /uno/x(5),w
COMMON j(4)                   ! COMMON a,b,r,i,s,m,j(4)
COMMON /uno/y(3,5),z(5),t     ! COMMON /uno/x(5),w,y(3,5),z(5),t
a=1; b=2; r=3; i=4
x=88; w=10; y=99
CALL compleccion
PRINT*, ' COMMON en blanco : '
PRINT*, ' a, b, r, i, s, m = ', a, b, r, i, s, m
PRINT*, ' j = ', j
PRINT*, ' COMMON /uno/ : '
PRINT*, ' x = ', x
PRINT*, ' w = ', w
PRINT*, ' y = ', y
PRINT*, ' z = ', z
PRINT*, ' t = ', t
END

SUBROUTINE compleccion
COMMON a,b,r,i,s,m,j(4)
COMMON /uno/xxx(5),www,yyy(3,5),zzz(5),ttt

s=5; m=6; j=77
zzz=-1; ttt=3.14
END