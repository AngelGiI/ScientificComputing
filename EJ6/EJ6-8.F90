PROGRAM ej6_8

PRINT*, ' ADJUSTL  ', ADJUSTL(' ABC    ')
PRINT*, ' ADJUSTR  ', ADJUSTR(' ABC    ')
PRINT*, ' TRIM     ', TRIM('luna  ')
PRINT*, ' LEN      ', LEN('luna  ')
PRINT*, ' LEN_TRIM ', LEN_TRIM('luna  ')
PRINT*, ' REPEAT   ', REPEAT('Ab',3)

PRINT*, ' INDEX    ', INDEX('banana','an')
PRINT*, ' INDEX    ', INDEX('banana','an',.TRUE.)
PRINT*, ' SCAN     ', SCAN('banana','an')
PRINT*, ' SCAN     ', SCAN('banana','an',.TRUE.)
PRINT*, ' VERIFY   ', VERIFY('banana','nbc')
PRINT*, ' VERIFY   ', VERIFY('banana','nbc',.TRUE.)

ENDPROGRAM ej6_8