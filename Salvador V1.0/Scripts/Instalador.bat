@CHCP 65001 > NUL
@echo off

set rutaDestino=C:\"Program Files"\"Salvador by Mori M"
set escritorioPublico=C:\Users\Public\Desktop
set paquetePrograma=..\..\"Salvador V1.0"

REM IF exist directorio\nul (echo.) ELSE (echo.)

echo.

REM Creando	->	C:\"Program Files"\"Salvador by Mori M."
echo  - Creando directorio %rutaDestino%
echo.
echo mkdir %rutaDestino%
echo.
mkdir %rutaDestino%


echo.
echo.
echo.


REM Copiando de	->	..\..\"Salvador V1.0"
REM           a	->	C:\"Program Files"\"Salvador by Mori M."
echo  - Copiando de %paquetePrograma% a %rutaDestino%
echo.
echo xcopy %paquetePrograma% %rutaDestino% /s /e 
echo.
xcopy %paquetePrograma% %rutaDestino% /s /e 


echo.
echo.
echo.


REM Intentando crear un link al escritorio público
echo  - Creando enlace simbólico de Salvador.bat al escritorio público
echo.
echo xcopy %rutaDestino%\Scripts\Salvador.bat %escritorioPublico%  /k /b
echo.
xcopy %rutaDestino%\Scripts\Salvador.bat %escritorioPublico%  /k /b


echo.
echo.

pause