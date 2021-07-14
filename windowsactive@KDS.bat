@Echo off
chcp 65001
cls
SETLOCAL
set server= %1
if "%1"=="" ( set server=kms.ddns.net ) else ECHO using custom server %server%

CALL :check_Permissions || GOTO exithandle
CALL :checkserver %server% || GOTO exithandle
cls
timeout /t 3 /nobreak > NUL

ECHO Script được viết bởi KudouSterain
ECHO fb.com/Kudou.D.Sterain
ECHO ---
ECHO Bạn có thể share đến bất cứ đâu nếu ghi credit.
ECHO Script không xài được thì báo mình.
ECHO ---
ECHO Script Version: 1.0 [forked by darealpaoo]
ECHO Phiên bản này mình đã đổi sang server "kms.ddns.net", hoạt động tốt.
ECHO Lỗi được biết:
ECHO 1) Kích hoạt Windows 10 Home không được. Tức là ấn số "0".
ECHO 2) Gỡ Key không được. Tức là ấn số "7" sẽ bị lỗi.
ECHO Vui lòng chờ 10 giây...
timeout /t 10 /nobreak > NUL
cls

ECHO Tất cả version bên dưới đều là bản dùng thử 180 ngày.
ECHO bạn có thể active lại sau khi hết hạn.
ECHO Không nên xài ở công ty lớn.

@REM window 10 home
SET list[0]=TX9XD-98N7V-6WMQ6-BX7FG-H8Q99
@REM window 10 pro
SET list[1]=W269N-WFGWX-YVC9B-4J6C9-T83GX
@REM windows 10 education
SET list[2]=NW6C2-QMPVW-D7KKK-3GKT6-VCFB2
@REM window 10 enterprise broken
SET list[3]=NPPR9-FWDCX-D2C8J-H872K-2YT43
@REM window 10 enterprise LTSB 2015
SET list[4]=WNMTR-4C88C-JK8YV-HQ7T2-76DF9
@REM window 10 enterprise LTSB 2016
SET list[5]=DCPHK-NFMTC-H88MJ-PFHPY-QJ4BJ
@REM window 10 enterprise LTSC 2019
SET list[6]=M7XTQ-FN8P6-TTKYV-9D4CC-J462D

SET currentkey=%list[0]%
ECHO 0.Windows 10 Home
ECHO 1.Windows 10 Pro
ECHO 2.Windows 10 Education
ECHO 3.Windows 10 Enterprise
ECHO 4.Windows 10 Enterprise LTSB 2015
ECHO 5.Windows 10 Enterprise LTSB 2016
ECHO 6.Windows 10 Enterprise LTSC 2019
ECHO 7.Gỡ key

CHOICE /N /C:1234567 /M "Chọn version để lụm active (0-6):"%1
if %ERRORLEVEL% GEQ 0 ( 
    if %ERRORLEVEL% LEQ 6 ( call set currentkey=%%list[%ERRORLEVEL%]%% ) else (
    ECHO Chọn tùm bậy.
    GOTO exithandle
    )
) else if %ERRORLEVEL% == 7 (
    cscript slmgr.vbs /ckms >nul
    cscript slmgr.vbs /cpky >nul
    ECHO Gỡ key thành công. !!!
    timeout /t 3 /nobreak
    EXIT /B 0
) else (
    ECHO Chọn tùm bậy.
    GOTO exithandle
    )

ECHO %currentkey%
ECHO Server %server% đang kích hoạt cho bạn, chờ tý...
cscript slmgr.vbs /upk >nul
cscript slmgr.vbs /ckms >nul
cscript slmgr.vbs /cpky >nul
cscript slmgr.vbs /ipk %currentkey% >nul
cscript slmgr.vbs /skms %server% >nul
cscript slmgr.vbs /ato >nul
slmgr /xpr
ECHO Active xong rồi, khởi động máy lại nhé!!!
timeout /t 10 /nobreak
EXIT /B 0
@REM function list
:check_Permissions
echo Đang check quyền Admin ...
timeout /t 1 /nobreak > NUL
net session >nul 2>&1
if errorlevel 0 (
    echo Đã có quyền Admin, tiến hành thôi.
    EXIT /B 0
) else (
    echo Vui lòng chạy file dưới quyền Admin nhé!
    EXIT /B 1
)
:checkserver
echo Đang check Server...
ping -n 2 %~1 | find "TTL=" >nul
ECHO %~1
if errorlevel 1 (
    echo Server hỏng rồi không kích hoạt được!
    EXIT /B 1
) else (
    echo Sever đã ô kê.
)
EXIT /B 0
:exithandle
timeout /t 3 
EXIT /B 0
pause >nul
