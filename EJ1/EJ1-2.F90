n=3
x(1:n)=(/1,2,3/)
DO i = 1,2
	y = SUM(x**i,n)
	PRINT*, 'x = ', x, ' y = ', y
ENDDO
END