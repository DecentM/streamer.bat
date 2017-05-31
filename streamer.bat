@echo off
:start

set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
rem: echo hour=%hour%
set min=%time:~3,2%
if "%min:~0,1%" == " " set min=0%min:~1,1%
rem echo min=%min%
set secs=%time:~6,2%
if "%secs:~0,1%" == " " set secs=0%secs:~1,1%
rem echo secs=%secs%
set datetimef=%hour%:%min%

echo %datetimef% > streamtime.txt
echo %datetimef%:%secs%: Wrote system time to streamtime.txt

ping 1.1.1.1 -n 1 -w 1500 > nul

wmic /OUTPUT:cpuload.temp cpu get loadpercentage
rem echo Wrote 1

more +1 cpuload.temp > cpuload.temp1
rem echo Wrote 2

set /p var=<cpuload.temp1
set var=%var: =%

set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
rem: echo hour=%hour%
set min=%time:~3,2%
if "%min:~0,1%" == " " set min=0%min:~1,1%
rem echo min=%min%
set secs=%time:~6,2%
if "%secs:~0,1%" == " " set secs=0%secs:~1,1%
rem echo secs=%secs%
set datetimef=%hour%:%min%

echo %var%>cpuload.txt
echo %datetimef%:%secs%: Wrote cpu load to cpuload.txt

ping 1.1.1.1 -n 1 -w 1500 > nul

for /f "skip=1" %%p in ('wmic os get freephysicalmemory') do ( 
  set m=%%p
  goto :done
)
:done
set vark=1024000
set var=102400
set /a out=%m%/%vark%
set /a m=%m%/%var%
set var=%m%:~3%

set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
rem: echo hour=%hour%
set min=%time:~3,2%
if "%min:~0,1%" == " " set min=0%min:~1,1%
rem echo min=%min%
set secs=%time:~6,2%
if "%secs:~0,1%" == " " set secs=0%secs:~1,1%
rem echo secs=%secs%
set datetimef=%hour%:%min%

echo %out%.%m%GB>freemem.txt
echo %datetimef%:%secs%: Wrote free memory to freemem.txt

ping 1.1.1.1 -n 1 -w 1500 > nul

goto :start
