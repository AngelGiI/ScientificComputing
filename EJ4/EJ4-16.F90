n = 25
odi: DO i = 1, n
       PRINT*, ' i =', i

       odj: DO j = 1, n
         odk: DO k = 1, n
                IF (k == i+j) CYCLE odi     ! GOTO 300
                IF (k+i+j == 13) GOTO 150
                IF (k+i+j == 10) EXIT odj   ! GOTO 250
              ENDDO odk

              PRINT*, ' j =', j
              CYCLE odj              ! GOTO 200
              150 CONTINUE           ! se puede quitar CONTINUE
              PRINT*, ' i+j+k = 13'  ! y poner     150 PRINT*,...
            ENDDO odj

  PRINT*, ' i+j+k = 10'
ENDDO odi
END