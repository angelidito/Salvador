@CHCP 65001 > NUL
@echo off

REM Dimensiones y color de la ventana
color 0c
mode con cols=75
mode con lines=20

REM -------------------------------------------------
REM Ruta por defecto donde se guardan las copias en
REM el volumen elegido \CopiasVolumenes\letraVolumen
REM -------------------------------------------------
set rutaParaLimpiar=CopiasVolumenes

REM -------------------------------------------------

:inicio
echo.
echo Escriba la letra del volumen del que se quiere borrar tanto la copia
echo como la fecha de copia.
echo.
set /p volumenParaLimpiar=Letra: 

REM -------------------------------------------------
CLS
echo.

REM -------------------------------------------------
REM Comprueba si existe el directorio donde se guarda
REM 		   la fecha de la ultima copia y lo borra.
IF exist ..\Fechas\%volumenParaLimpiar%\nul (echo Va a borrar: && rd /S ..\Fechas\%volumenParaLimpiar% && echo Fecha de ultima copia eliminada) ELSE (echo No se encuentra fecha copia de este volumen. && echo. && echo Es posible que haya sido borada o que nunca se haya realizado una copia. && echo. && pause && CLS)

REM -------------------------------------------------
echo.
echo Escriba la letra del volumen donde se ha hecho la copia.
echo.
set /p volumenDondeEstaLaCopia=Letra:

REM Compueba que esten bien los datos
:esCorrectoDestino
CLS
echo.
echo     Volumen donde limpiar: %volumenDondeEstaLaCopia%
echo.
echo ?Es correcto (S/N)?

set /p decision=

if s == %decision% (set rutaEnDestinoCompleta=%rutaDestino%\%origen% && goto esCorrectaRuta)
if S == %decision% (set rutaEnDestinoCompleta=%rutaDestino%\%origen% && goto esCorrectaRuta)
if n == %decision% goto inicio
if N == %decision% goto inicio

goto esCorrectoDestino

REM -------------------------------------------------

:esCorrectaRuta
CLS
echo.
echo  Ruta donde esta la copia: %volumenDondeEstaLaCopia%:\%rutaParaLimpiar%\%volumenParaLimpiar%
echo.
echo ?Es correcta la ruta a limpiar (S/N)?

set /p decision=
if s == %decision% goto limpieza
if n == %decision% goto setRutaParaLimpiar
goto esCorrectaRuta


:setRutaParaLimpiar
echo.
echo.
echo Complete la ruta que desea limpiar:
set /p %rutaParaLimpiar%=%volumenDondeEstaLaCopia%:\
goto esCorrectaRuta

REM -------------------------------------------------

:limpieza

REM Comprueba si existe el directorio donde a borrar
REM Lo borra si existe. Si no, vuelve a comenzarl el programa.
IF exist %volumenDondeEstaLaCopia%:\%rutaParaLimpiar%\%volumenParaLimpiar%\nul (rd %volumenDondeEstaLaCopia%:\%rutaParaLimpiar%\%volumenParaLimpiar%\ /s && echo Copia eliminada. && goto Fin) ELSE (goto Reboot)


:Reboot
echo.
echo No existe el directorio.
echo El programa se va reiniciar.
pause
"limpiar.bat"
goto FinSinPause

REM -------------------------------------------------
REM -------------------------------------------------
REM ---------------------- YA -----------------------
REM -------------------------------------------------
REM -------------------------------------------------
:Fin
pause
:FinSinPause
