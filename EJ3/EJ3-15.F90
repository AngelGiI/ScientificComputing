REAL y(10), z(4,10)
CHARACTER(LEN=2) alfa
READ (*,*) x, y(1), z(2,6), alfa
WRITE (*,*) x, y(1), z(2,6)+x*y(1), alfa
WRITE (*,*) 'y1=',y(1),'   alfa=',alfa
END