@echo off
setlocal

echo ==============================
echo  GenAllProto - Protocol Sync
echo ==============================

rem 현재 bat(GenAllProto)가 있는 폴더 (...\Common\Protocol\)
set "BASE_DIR=%~dp0"

rem Protocol 기준으로 두 단계 위 = cshapPuzzleBubble 루트
pushd "%BASE_DIR%\..\.."
set "ROOT_PATH=%cd%"
popd

rem 경로 셋업
set "PROTO_DIR=%ROOT_PATH%\Common\Protocol"
set "TOOLS_BIN=%ROOT_PATH%\Tools\bin"

rem protoc 위치 추론 (Tools\bin에 있으면 그거 쓰고, 아니면 PATH에 있는 protoc.exe)
set "PROTOC=%TOOLS_BIN%\protoc.exe"
if not exist "%PROTOC%" (
    set "PROTOC=protoc.exe"
)

rem 원래 GenProto에서 쓰던 상대 출력 경로 그대로 유지
set "REL_OUT_SERVER=\Server\Server\Packet\Generated\"
set "REL_OUT_CLIENT=\Client\Assets\Scripts\Packet\Generated\"

rem 실제 파일이 생성될 절대 경로
set "ABS_OUT_SERVER=%ROOT_PATH%%REL_OUT_SERVER%"
set "ABS_OUT_CLIENT=%ROOT_PATH%%REL_OUT_CLIENT%"

echo ROOT_PATH       = %ROOT_PATH%
echo PROTO_DIR       = %PROTO_DIR%
echo TOOLS_BIN       = %TOOLS_BIN%
echo PROTOC          = %PROTOC%
echo ABS_OUT_SERVER  = %ABS_OUT_SERVER%
echo ABS_OUT_CLIENT  = %ABS_OUT_CLIENT%
echo.

rem 폴더 없으면 생성
if not exist "%ABS_OUT_SERVER%" (
    echo [GenAll] Create directory: %ABS_OUT_SERVER%
    mkdir "%ABS_OUT_SERVER%"
)
if not exist "%ABS_OUT_CLIENT%" (
    echo [GenAll] Create directory: %ABS_OUT_CLIENT%
    mkdir "%ABS_OUT_CLIENT%"
)

rem proto 파일 체크
if not exist "%PROTO_DIR%\Protocol.proto" (
    echo [ERROR] %PROTO_DIR%\Protocol.proto not found
    pause
    exit /b 1
)
if not exist "%PROTO_DIR%\Enum.proto" (
    echo [ERROR] %PROTO_DIR%\Enum.proto not found
    pause
    exit /b 1
)
if not exist "%PROTO_DIR%\Struct.proto" (
    echo [ERROR] %PROTO_DIR%\Struct.proto not found
    pause
    exit /b 1
)

echo --- Step 1) protoc for SERVER ---
pushd "%PROTO_DIR%"
echo [CMD] "%PROTOC%" -I=./ --csharp_out=%ABS_OUT_SERVER% ./Protocol.proto ./Enum.proto ./Struct.proto
"%PROTOC%" -I=./ --csharp_out=%ABS_OUT_SERVER% ./Protocol.proto ./Enum.proto ./Struct.proto
if errorlevel 1 goto :error
popd
echo [OK] Server C# generated
echo.

echo --- Step 2) protoc for CLIENT ---
pushd "%PROTO_DIR%"
echo [CMD] "%PROTOC%" -I=./ --csharp_out=%ABS_OUT_CLIENT% ./Protocol.proto ./Enum.proto ./Struct.proto
"%PROTOC%" -I=./ --csharp_out=%ABS_OUT_CLIENT% ./Protocol.proto ./Enum.proto ./Struct.proto
if errorlevel 1 goto :error
popd
echo [OK] Client C# generated
echo.

echo --- Step 3) PacketGenerator (SERVER) ---
pushd "%TOOLS_BIN%"
echo RUN: PacketGenerator.exe -o %REL_OUT_SERVER% -t 1
START "" PacketGenerator.exe -o %REL_OUT_SERVER% -t 1
popd
echo.

echo --- Step 4) PacketGenerator (CLIENT) ---
pushd "%TOOLS_BIN%"
echo RUN: PacketGenerator.exe -o %REL_OUT_CLIENT% -t 0
START "" PacketGenerator.exe -o %REL_OUT_CLIENT% -t 0
popd
echo.

echo All proto packets generated successfully!
pause
exit /b 0

:error
echo.
echo !!! ERROR: protoc failed !!!
pause
exit /b 1
