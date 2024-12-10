EXTERNAL fun1, fun2, sin
x=1.5; n=3
CALL ameba (x, n, y1, fun1)      ! y1 = x**(5-n) = 2.25
CALL ameba (x, n, y2, fun2)      ! y2 = 3*x*(5-n) = 9
s = sin (y1, y2, 6.0, x)         ! s = y2/y1 + 6/x = 8
PRINT*, y1, y2, s
END

SUBROUTINE ameba (x, n, y, f)
  y = f(x, 5, n)
END

FUNCTION fun1 (x, i, j)
  fun1 = x**(i-j)
END

FUNCTION fun2 (x, i, j)
  fun2 = 3*x*(i-j)
END

FUNCTION sin (a, b, c, d)
  sin = b/a + c/d
END