@echo off
setlocal
set "APP_HOME=%~dp0"
set "WRAPPER_JAR=%APP_HOME%gradle\wrapper\gradle-wrapper.jar"
cd /d "%APP_HOME%"

set "JAVA_EXE=java.exe"
if defined JAVA_HOME (
  set "CANDIDATE_JAVA=%JAVA_HOME%"
  set "CANDIDATE_JAVA=%CANDIDATE_JAVA:"=%"
  if exist "%CANDIDATE_JAVA%\bin\java.exe" set "JAVA_EXE=%CANDIDATE_JAVA%\bin\java.exe"
)

if exist "%WRAPPER_JAR%" (
  "%JAVA_EXE%" -cp "%WRAPPER_JAR%" org.gradle.wrapper.GradleWrapperMain %*
  exit /b %ERRORLEVEL%
)

where gradle >nul 2>nul
if %ERRORLEVEL% EQU 0 (
  gradle %*
  exit /b %ERRORLEVEL%
)

echo Gradle wrapper jar is missing and no system Gradle was found.
echo Expected: %WRAPPER_JAR%
exit /b 1
