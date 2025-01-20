@CHCP 1252 >NUL
CD "%~dp0%"
@SetLocal
@echo off
@set proj=sped

@Set OutPut=sped

Rem Variaveis de ambiente que precedem a linha de comando bhmk2
@Set HB_BUILD_CONTRIB_DYN=
@Set HB_BUILD_DYN=
@Set HB_BUILD_SHARED=
@Set HB_BUILD_STRIP=
@Set HB_COMPILER=
@Set HB_INSTALL_PREFIX=

if exist %OutPut%.exe @del %OutPut%.exe >>nul
@Set HB_ARCHITECTURE=w32
@Set OLDPATH=%PATH%

REM Path da IDE
@Set BaseDIR=C:\devprg\HMGDES~1\ide


REM Ajuste aqui seus Paths caso queira criar uma nova configuração

REM  Path da Minigui
@Set HMGRPATH=C:\devprg\HMGDES~1\IDE\Tools\Minigui

REM Path do Harbour
@Set HMGRHARBOUR=C:\devprg\HMGDES~1\IDE\Tools\Harbour

REM Path do Compilador
@Set HMGRCOMP=C:\devprg\HMGDES~1\IDE\Tools\Bcc

REM Deixando os Binarios disponiveis
@Set PATH=%HMGRHARBOUR%\bin;%HMGRCOMP%\bin

@Set HB_COMPILER=bcc
Echo Aguarde... Compilando o projeto...

HBMK2 %proj% 1>%proj%.log 2>&1

If exist %OUTPUT%.exe (
Del error*.htm
Del _temp.*
Del ???_log.htm
)

Goto fim

:fim
@Set HMGRPATH=
@Set HMGRHARBOUR=
@Set HMGRCOMP=
@Set PATH=%OLDPATH%
@EndLocal
