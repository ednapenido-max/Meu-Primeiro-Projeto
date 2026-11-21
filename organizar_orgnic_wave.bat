@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"

echo ==================================================
echo  Organizando a pasta: %cd%
echo  Este script so CRIA pastas e MOVE arquivos.
echo  Nada e apagado e nada e sobrescrito.
echo ==================================================
echo.
echo IMPORTANTE: este arquivo precisa estar DENTRO da pasta ORGNIC WAVE.
echo Pasta atual: %cd%
echo.
pause

rem ---------- cria as pastas ----------
for %%D in (
  "01_Financeiro"
  "02_Aulas_e_Anotacoes"
  "03_Pesquisa_e_Modelagem"
  "03_Pesquisa_e_Modelagem\Referencias_Visuais"
  "04_Campanhas"
  "04_Campanhas\Criativos"
  "04_Campanhas\VSL_e_Copy"
  "05_Programas_e_Atalhos"
  "99_Revisar"
) do if not exist %%D mkdir %%D

echo.
echo ---------- movendo arquivos ----------

rem 01 Financeiro
call :mv "*FINANCEIRO*.xlsx"            "01_Financeiro"

rem 02 Aulas e anotacoes
call :mv "*aula_mentalidade*.docx"      "02_Aulas_e_Anotacoes"
call :mv "*WHATSAPP_ALUNOS*.docx"       "02_Aulas_e_Anotacoes"

rem 03 Pesquisa e modelagem
call :mv "*PARA_MODELAR*.docx"          "03_Pesquisa_e_Modelagem"
call :mv "*ESCOLHER_AVATAR*.docx"       "03_Pesquisa_e_Modelagem"

rem 04 Campanhas
call :mv "*Campanha*VSL*.html"          "04_Campanhas\VSL_e_Copy"

rem 05 Programas e atalhos
call :mv "CapCut*.lnk"                  "05_Programas_e_Atalhos"
call :mv "Zoom*.lnk"                    "05_Programas_e_Atalhos"
call :mv "Claude*.lnk"                  "05_Programas_e_Atalhos"
call :mv "Organic*.lnk"                 "05_Programas_e_Atalhos"

rem Imagens: nao da para saber pelo nome se e criativo ou referencia.
rem Vao para 99_Revisar para voce arrastar para a pasta certa.
call :mv "*.jpg"                        "99_Revisar"
call :mv "*.jpeg"                       "99_Revisar"
call :mv "*.png"                        "99_Revisar"
call :mv "*.webp"                       "99_Revisar"

echo.
echo ---------- arquivos que continuam soltos (nao classifiquei) ----------
for %%F in (*) do (
  if /i not "%%~nxF"=="%~nx0" echo   %%~nxF
)
echo.
echo Pronto. Nada foi apagado.
echo Imagens estao em 99_Revisar: arraste a do anuncio (gelatina) para
echo 04_Campanhas\Criativos e o print do video "59 mil" para
echo 03_Pesquisa_e_Modelagem\Referencias_Visuais.
echo.
pause
exit /b 0

:mv
rem %~1 = padrao do arquivo   %~2 = pasta de destino
for %%F in ("%~1") do (
  if exist "%%F" (
    if exist "%~2\%%~nxF" (
      echo   [PULADO - ja existe no destino] %%~nxF
    ) else (
      move "%%F" "%~2\" >nul
      echo   [OK] %%~nxF  --^>  %~2
    )
  )
)
exit /b 0
