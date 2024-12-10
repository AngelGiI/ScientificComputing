PROGRAM aleatorio

INTEGER t1(8), t2(8)
INTEGER i, numrep, semilla(1)
REAL x, sx, tdif
CHARACTER(LEN=8) date1, date2
CHARACTER(LEN=10) time1, time2
CHARACTER(LEN=5) zona

PRINT*, ' numero de repeticiones'
READ*, numrep
PRINT*, ' semilla inicial'
READ*, semilla
CALL RANDOM_SEED (PUT=semilla)

CALL DATE_AND_TIME (VALUES=t1, DATE=date1, ZONE=zona, TIME=time1)
DO i = 1, numrep
  CALL RANDOM_NUMBER (x)
  sx = SIN(x)
ENDDO
CALL DATE_AND_TIME (VALUES=t2, TIME=time2, DATE=date2)

PRINT*, ' zona=', zona
PRINT*, ' date1=', date1, '  date2=', date2
PRINT*, ' time1=', time1, '  time2=', time2

tdif = 0.001*(t2(8)-t1(8)) + (t2(7)-t1(7)) + 60.*(t2(6)-t1(6)) +   &
       3600.*(t2(5)-t1(5))
PRINT*, ' tdif =', tdif

ENDPROGRAM aleatorio