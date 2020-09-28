@CHCP 65001 > NUL
@echo off

REM Dimensiones y color de la ventana
color 0c
mode con cols=75
mode con lines=20

REM -------------------------------------------------
REM Ruta por defecto donde se guardarán las copias en
REM el volumen elegido \CopiasVolumenes\letraVolumen
REM -------------------------------------------------
set rutaDestino=CopiasVolumenes

REM -------------------------------------------------
REM -------------------------------------------------
REM -------------------------------------------------
REM -------------------------------------------------
REM -------------------------------------------------


:setOrigen
echo IMPORTANTE: ejecútame como ADMINISTRADOR
pause
echo.
set /p origen=Letra del volumen a copiar: 


REM :esCorrectoOrigen
:DestinoYOrigenNoCorrectos
CLS
echo.
echo          Volumen a copiar: %origen%

REM -------------------------------------------------
REM -------- Lee la fecha ---------------------------
REM -------------------------------------------------


REM Comprueba si existe el directorio donde se guarda la fecha de la última copia
IF exist ..\Fechas\%origen%\nul (echo.) ELSE (mkdir ..\Fechas\%origen% && echo 11-11-1990 > ..\Fechas\%origen%\fechaUltimoSalvado.txt)

setlocal enabledelayedexpansion
set SEPARATOR=/
set fechaUltimaCopia=
for /f "delims=" %%a in (..\Fechas\%origen%\\fechaUltimoSalvado.txt) do (
  set currentline=%%a
  set fechaUltimaCopia=!fechaUltimaCopia!!currentline!
)

REM Si la fecha no es la fecha por defecto dice cuándo fue la última copia.
IF %fechaUltimaCopia% NEQ 11-11-1990 echo Última copia a fecha de %fechaUltimaCopia%

REM -------------------------------------------------
REM -------------------------------------------------
REM -------------------------------------------------
REM -------------------------------------------------
REM -------------------------------------------------


echo.

set /p destino=Letra del volumen donde copiar: 


:esCorrectoDestino
CLS
echo.
echo          Volumen a copiar: %origen%
IF %fechaUltimaCopia% NEQ 11-11-1990 echo Última copia a fecha de %fechaUltimaCopia%
echo      Volumen donde copiar: %destino%
echo.
echo ?Es correcto (S/N)?

set /p decision=
if s == %decision% (set rutaEnDestinoCompleta=%rutaDestino%\%origen% && goto esCorrectaRuta)
if n == %decision% goto DestinoYOrigenNoCorrectos
echo.
goto esCorrectoDestino


:esCorrectaRuta
CLS
echo.
echo          Volumen a copiar: %origen%
IF %fechaUltimaCopia% NEQ 11-11-1990 echo Última copia a fecha de %fechaUltimaCopia%
echo      Volumen donde copiar: %destino%
echo Ruta donde se va a copiar: %destino%:\%rutaEnDestinoCompleta%
echo ?Es correcta la ruta de destino (S/N)?

set /p decision=
if s == %decision% (goto XXcopy)
if n == %decision% goto esCorrectaRuta
goto setRuta


:setRutaDestino
echo.
echo.
echo Nueva ruta destino (si no existe se creará):
set /p %rutaDestino%=%destino%:\
set rutaEnDestinoCompleta=%rutaDestino%
echo %rutaDestino%
pause
goto esCorrectaRuta


:XXcopy
REM Comprueba si existe el directorio donde se va a guardar la copia.
REM Si no existe lo crea.
IF exist %destino%:\%rutaEnDestinoCompleta%\nul (echo.) ELSE (echo Creando directorio %destino%:\%rutaEnDestinoCompleta% && mkdir %destino%:\%rutaEnDestinoCompleta% )


CLS 
echo.
echo Ejecutando comando:
echo.
echo xcopy %origen%:\ %destino%:\%rutaEnDestinoCompleta% /s /e /h /d:%fechaUltimaCopia%
echo.
echo.
REM -------------------------------------------------
REM -------------- XCOPY en toda regla --------------
REM -------------------------------------------------
xCOPY      %origen%:\ %destino%:\%rutaEnDestinoCompleta% /s /e /h /d:%fechaUltimaCopia%

echo.
echo.
echo.
echo.
echo.
echo Copia realizada.
echo.
echo.
echo - Si no desea guardar la fecha de éste salvado presione las
echo teclas "Ctrl" y "C". A continuacion presione "S" y "Enter".
echo.
echo - Si desea guardar la fecha de éste salvado

pause


REM -------------------------------------------------
REM --- Guarda la nueva fecha -----------------------
REM -------------------------------------------------
echo Actulizando fecha.
echo.


REM Guarda la fecha en las variable dia mes y anno
for /f "usebackq skip=1 tokens=1-3" %%g in (`wmic Path Win32_LocalTime Get Day^,Month^,Year ^| findstr /r /v "^$"`) do (
  set dia=00%%g
  set mes=00%%h
  set anno=%%i
  )

REM Rellena con ceros el mes y el dia
set mes=%mes:~-2%
set dia=%dia:~-2%


REM Saca a txt la fecha con el formato MM-DD-YYYY
echo %mes%-%dia%-%anno% > ..\Fechas\%origen%\fechaUltimoSalvado.txt
echo.
echo Fecha actualizada.

REM -------------------------------------------------
REM -------------------------------------------------
REM --------- FIN. POR FIN, JODER, YA ESTÁ ----------
REM -------------------------------------------------
REM -------------------------------------------------

pause
