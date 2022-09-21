@echo off
setlocal enableextensions enabledelayedexpansion

:init-param
set compress=compress

set bindir=%~dp0\bin
set codebook=packed_codebooks_aoTuV_603.bin

set input=.
set output=.\output
set tempdir=%temp%\tmp%random%

if "%~1" neq "" (
 set input=%~1
)
if "%~2" neq "" (
 set output=%~2
)

:check-env
echo ===== Genshin Impact Audio Extractor =====
echo.
where /q java || (
 echo Error: Cannot find Java in environment.
 pause
 exit /b 2
)

:check-param
if not exist "%input%" (
 echo Error: Input does not exist.
 pause
 exit /b 1
)
if not exist "%output%" (
 md "%output%" || (
  pause
  exit /b 2
 )
) else if not exist "%output%\*" (
 echo Error: Output is not a directory.
 pause
 exit /b 1
)
md "%tempdir%" || (
 echo Error: Cannot create temp directory.
 pause
 exit /b 2
)

:process
"%bindir%\quickbms.exe" -F {}.pck "%bindir%\wavescan.bms" "%input%" "%tempdir%" || (
 rd /s /q "%tempdir%"
 pause
 exit /b 2
)
echo.
for %%f in ("%tempdir%\*.wav") do (
 echo Processing "%%~nxf"...
 java -jar "%bindir%\ptadpcminflate.jar" "%%f" "%output%\%%~nf.wav"
 if !errorlevel! equ 0 (
  del "%%f"
  if "%compress%" equ "compress" (
   "%bindir%\flac\flac.exe" "%output%\%%~nf.wav" -o "%output%\%%~nf.flac" && (
    del "%output%\%%~nf.wav"
   ) || echo Warning: Failed to encode "%output%\%%~nf.wav" to FLAC.
  )
  echo.
 ) else if !errorlevel! equ 1 (
  echo Passing to ww2ogg to handle...
  echo.
  "%bindir%\ww2ogg\ww2ogg.exe" "%%f" -o "%%~dpnf.ogg" --pcb "%bindir%\ww2ogg\%codebook%" && (
   "%bindir%\revorb.exe" "%%~dpnf.ogg" "%output%\%%~nf.ogg" && (
    del "%%f" "%%~dpnf.ogg"
   )
  ) || echo Warning: Failed to convert "%%f" to OGG.
  echo.
 ) else (
  del "%output%\%%~nf.wav" 2>nul
  echo Warning: Failed to parse "%%f".
  echo.
 )
)

:cleanup
if exist "%tempdir%\*.wav" (
 if not exist "%output%\bad\*" (
  md "%output%\bad" 2>nul
 )
 move /y "%tempdir%\*.wav" "%output%\bad"
 echo Failed to process some files. Moved to "%output%\bad".
)
rd /s /q "%tempdir%"
echo Extraction completed.
pause
