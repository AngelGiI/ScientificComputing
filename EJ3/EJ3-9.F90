a=1.2; b=2.3; c=3.4; d=4.5; e=5.6; f=6.7; g=7.8
x1 = a + b*c          ! equivalente a  x1 = a + (b*c)
x2 = a*b/c            ! equivalente a  x2 = (a*b) / c
x3 = a*b-c+d*e**f-g   ! equivalente a  x3 = (a*b) - c + d*(e**f) - g
x4 = a**b**c          ! equivalente a  x4 = a**(b**c)
x5 = -a**b            ! equivalente a  x5 = -(a**b)
PRINT*, x1, a + (b*c)
PRINT*, x2, (a*b) / c
PRINT*, x3, (a*b) - c + d*(e**f) - g
PRINT*, x4, a**(b**c)
PRINT*, x5, -(a**b)
END