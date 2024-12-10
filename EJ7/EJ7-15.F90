CHARACTER(LEN=*), PARAMETER:: mensaje = &
       ' Aplicando la regla de L''Hôpital el limite es:'
flim = 3.5687
WRITE (*, '(A,F10.3)') mensaje, flim
END