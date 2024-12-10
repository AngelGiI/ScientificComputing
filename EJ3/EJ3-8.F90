CHARACTER(LEN=15) mes(12), dia(0:6), estacion
CHARACTER(LEN=3) submes, diasem, trozo*6
mes(1) = 'ENERO'
mes(7) = 'JULIO'
dia(3) = 'miercoles'
dia(6) = 'sabado'
estacion = 'primavera'
submes = mes(1)(2:4)      !  submes <- 'NER'
diasem = dia(3)(:3)       !  diasem <- 'mie'
trozo = estacion(5:)      !  trozo  <- 'avera '
PRINT*, mes(1), submes, dia(3), diasem, estacion, trozo
END
