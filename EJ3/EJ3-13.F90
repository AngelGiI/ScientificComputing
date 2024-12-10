LOGICAL a, b, c, d, e, f1, f2, f3, f4, f5, f6
a=.TRUE.; b=.TRUE.; c=.TRUE.; d=.FALSE.; e=.FALSE.

! Los siguientes pares de sentencias son equivalentes

f1 = a .AND. b .AND. c
f2 = (a .AND. b) .AND. c

f3 = .NOT.a .OR. b .AND. c
f4 = (.NOT.a) .OR. (b.AND.c)

f5 = .NOT.a .EQV. b .OR. c .NEQV. d .AND. e
f6 = ((.NOT.a) .EQV. (b.OR.c)) .NEQV. (d.AND.e)

PRINT*, f1, f2; PRINT*, f3, f4; PRINT*, f5, f6
END