@CHCP 65001 > NUL
@echo off

set escritorioPublico=C:\Users\Public\Desktop
set programVersion="Salvador V1.0"

set rutaEnEscritorio=C:\Users\%USERNAME%\Desktop\%programVersion%
set rutaDestino="%PROGRAMFILES%"\"Salvador by Mori M"\%programVersion%

REM echo %cd%
REM IF "C:\Windows\system32" == %cd%  ( echo. ) ELSE ( echo  Asegurate el instaldor lo ejecutas como administrador)
echo IMPORTANTE:
echo Asegurate de que ejecutas este programa como administrador.
echo.
pause

echo.

REM Creando -> C:\Program Files\Salvador by Mori M\"Salvador V1.0"
echo  - Creando directorio %rutaDestino%
echo.
echo mkdir %rutaDestino%
echo.
mkdir %rutaDestino%
echo.
pause

CLS
echo AVISO:
echo.
echo Antes de continuar copie la carpeta Salvador V1.0
echo a su escritorio si es que no lo esta ya.
echo.
echo Cuando ya este . . .
pause
CLS

REM Copiando de	->	Escritorio\Salvador V1.0
REM           a	->	C:\Program Files\Salvador by Mori M
echo  - Copiando de %rutaEnEscritorio% a %rutaDestino%
echo.
echo xcopy %rutaEnEscritorio% %rutaDestino% /s /e 
echo.
xcopy %rutaEnEscritorio% %rutaDestino% /s /e 

pause 
echo.
echo.
echo.


REM Intentando crear un link al escritorio publico
echo  - Creando enlace simbolico de Salvador.bat al escritorio publico
echo.
echo xcopy %rutaDestino%\Salvador.lnk  /k /b
echo.
xcopy %rutaDestino%\Scripts\Salvador.bat %escritorioPublico% /k /b

echo.
echo.

pause