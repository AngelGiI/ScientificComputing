INTEGER n(10), n1(3,5), c(4,4,4,4), hh(0:4), bb(-6:4,2:5,75:99)
REAL r1(5), r2(-2:4,6)
CHARACTER (LEN=15):: mes(12), dia(0:6)

n(3) = 4563
n1(2,4) = n1(1,3) + 89
hh(0) = -1
bb(-3,4,80) = bb(-5,2,90) + 2.3*c(3,3,3,1)
r2(-1,6) = r1(3) + r2(-2,3)
mes(2) = 'FEBRERO'
dia(0) = 'DOMINGO'
PRINT*, n(3), n1(2,4), hh(0), mes(2)
END