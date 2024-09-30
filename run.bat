@echo off

gcc -o hamming_distance HammingDistance.c

if %ERRORLEVEL% neq 0 (
    echo Compilation failed.
    exit /b 1
)

set "L_values=64 89 256"
set "N_values=100 1000"

for /f "tokens=1,2 delims= " %%A in ('echo %date% %time%') do set SEED=%%B

for %%L in (%L_values%) do (
    for %%N in (%N_values%) do (
        echo Running program with N=%%N, L=%%L, SEED=%SEED%

        hamming_distance %%N %%L %SEED%

        echo --------------------------------------
    )
)
pause
