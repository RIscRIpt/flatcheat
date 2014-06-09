@echo off
SET compiler=C:\FASM\FASM.EXE
IF EXIST %compiler% (
	color 0a
	SET include=C:\FASM\INCLUDE
	%compiler% flatcheat.asm
	echo.
	pause
) ELSE (
	color 0c
	echo flat assembler was not found on your computer
	echo You can get it at  flatassembler.net
	echo.
	echo Press Y to download it automatically
	echo Press N to exit
	CHOICE /N
	IF ERRORLEVEL 2 EXIT
	START download_fasm.vbs
	:exit
	echo.
)