@echo off
echo ========================================
echo   STARTING GYM MANAGEMENT SYSTEM (FIXED)
echo ========================================
echo.
echo Preparing Environment...
if not exist "src\main\webapp\WEB-INF\classes" mkdir "src\main\webapp\WEB-INF\classes"

echo Compiling for Compatibility (Java 8 mode)...
javac --release 8 -cp "src/main/webapp/WEB-INF/lib/*" -d src/main/webapp/WEB-INF/classes src/main/java/main/*.java
echo.
echo Starting Server on http://localhost:8080/
echo Press Ctrl+C to stop the server. (KEEP THIS WINDOW OPEN)
echo.
java -jar jetty-runner.jar src/main/webapp
