INTRINSIC sin, cos, exp
a=3.141592; b=-a
r = fun (sin, cos, exp, a, b, 4)
PRINT *, r
END

FUNCTION fun (f1, f2, f3, a, b, n)     ! fun = ((sin(a)+cos(b)+
fun = (f1(a) + f2(b) + f3(a+b)) ** n   ! exp(a+b))**n
END