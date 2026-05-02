@echo off
echo ========================================
echo   STARTING GYM MANAGEMENT SYSTEM (FIXED)
echo ========================================
echo.
echo Preparing Environment...
if not exist "src\main\webapp\WEB-INF\classes" mkdir "src\main\webapp\WEB-INF\classes"

echo Compiling for Compatibility (Java 8 mode)...
javac --release 8 -d src/main/webapp/WEB-INF/classes src/main/java/main/*.java
echo.
echo Starting Server on http://localhost:8080/Dashboard.jsp
echo Press Ctrl+C to stop the server.
echo.
java -jar jetty-runner.jar --port 8080 src/main/webapp
