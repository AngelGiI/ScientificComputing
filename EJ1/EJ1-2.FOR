      x = 2.3 + 5.2*4.78
      y = SQRT(x**2+3.5)
      e= EXP(1.0)
      pi= 2*ASIN(1.0)
      epi = EXP(1.0) + 2*ASIN(1.0)
      PRINT*, 'x = ', x, ' y = ', y
      PRINT*, 'e + pi = ', epi  
      PRINT*, 'e = ', e
      PRINT*, 'pi = ', pi
      fxy = LOG(0.1*x)/(SIN(y)+1.2) - (x+1)**2.6 +
     &      5*x/(x*y+1)
      PRINT*, 'f(x,y) = ', fxy
      END