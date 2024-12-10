LOGICAL a, f1, f2, f3, f4
CHARACTER*4 c1, c2, c3*8

a = .true.
x = 5
y = 7
z = 8
c1 = 'abcd'
c2 = '1234'
c3 = 'abcd1234'

! Los siguientes pares de sentencias son equivalentes

f1 = .NOT.a .OR. x+y < z
f2 = (.NOT.a) .OR. (x+y<z)

f3 = c1(1:4)//c2==c3 .AND. x*y<z .OR. a
f4 = ( ((c1(1:4)//c2)==c3) .AND. (x*y<z) ) .OR. a

PRINT*, f1, f2; PRINT*, f3, f4
END