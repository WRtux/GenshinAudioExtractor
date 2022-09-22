@echo off
setlocal enableextensions enabledelayedexpansion

set all_proxy=

set bindir=%cd%\bin
set copydir=%cd%\copy
set tempdir=%temp%\tmp%random%

echo Preparing...
del "%bindir%\..\extract.cmd" 2>nul
rd /s /q "%bindir%" "%copydir%" 2>nul
md "%bindir%" "%bindir%\ww2ogg" "%bindir%\flac" "%copydir%" || (
 echo Error: Cannot set up directories.
 pause
 exit /b 2
)
md "%tempdir%" || (
 echo Error: Cannot create temp directory.
 pause
 exit /b 2
)

echo Downloading and extracting...
pushd "%tempdir%"

echo : Extractor script
curl -# "https://raw.githubusercontent.com/WRtux/GenshinAudioExtractor/master/extract.cmd" -L -o extract.cmd || goto :fail
move extract.cmd "%bindir%\.." >nul

echo : QuickBMS
curl -# "https://aluigi.altervista.org/papers/quickbms.zip" -L -o quickbms.zip || goto :fail
curl -s "https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt" -L -o LICENSE.txt
tar -xmf quickbms.zip quickbms.exe quickbms.txt
del quickbms.zip
move quickbms.exe "%bindir%" >nul
move quickbms.txt "%copydir%\QuickBMS.txt" >nul
move LICENSE.txt "%copydir%\QuickBMS-LICENSE.txt" >nul

echo : Scanning BMS script
curl -# "https://raw.githubusercontent.com/Vextil/Wwise-Unpacker/master/Tools/wavescan.bms" -L -o wavescan.bms || goto :fail
move wavescan.bms "%bindir%" >nul

echo : PtADPCMInflate
curl -# "https://github.com/WRtux/PtADPCMInflate/releases/download/v0.2.1/ptadpcminflate.jar" -L -o ptadpcminflate.jar || goto :fail
move ptadpcminflate.jar "%bindir%" >nul

echo : ww2ogg
curl -# "https://github.com/hcs64/ww2ogg/releases/download/0.24/ww2ogg024.zip" -L -o ww2ogg.zip || goto :fail
tar -xmf ww2ogg.zip ww2ogg.exe packed_*.bin
tar -xmf ww2ogg.zip COPYING
del ww2ogg.zip
for %%f in (ww2ogg.exe packed_*.bin) do (
 move "%%f" "%bindir%\ww2ogg" >nul
)
move COPYING "%copydir%\ww2ogg-COPYING" >nul

echo : Revorb
curl -# "http://yirkha.fud.cz/progs/foobar2000/revorb.exe" -L -o revorb.exe || goto :fail
move revorb.exe "%bindir%" >nul

echo : FLAC
curl -# "https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.4.0-win.zip" -L -o flac.zip || goto :fail
tar -xmf flac.zip flac-1.4.0-win
del flac.zip
pushd flac-1.4.0-win
pushd Win64
for %%f in (flac.exe libFLAC.dll) do (
 move "%%f" "%bindir%\flac" >nul
)
popd
for %%f in (COPYING.Xiph COPYING.GPL) do (
 move "%%f" "%copydir%\FLAC-%%~nxf" >nul
)
popd
rd /s /q flac-1.4.0-win

popd
rd /s /q %tempdir%
echo Extractor has been set up.
pause
exit /b 0

:fail
popd
rd /s /q %tempdir%
echo Error: failed to download files.
pause
exit /b 1
