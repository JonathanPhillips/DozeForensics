::
:: Windows forensics
::
:: Please read the README.txt file for more information
::
@echo OFF
:: Make Results Directory with time/date stamp
set TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2%-%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%

::@echo TIMESTAMP=%TIMESTAMP%
set FOLDER="Results-%TIMESTAMP%"

md "%FOLDER%"

:: Get Host and User Info 

echo %DATE% %TIME% >> %FOLDER%\hostinfo.txt
echo. >> &FOLDER&\hostinfo.txt 
echo. >> &FOLDER&\hostinfo.txt
echo OS Details >> %FOLDER%\hostinfo.txt
echo ------------------------------------------------------------ >> %FOLDER%\hostinfo.txt
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" >> %FOLDER%\hostinfo.txt
hostname >> %FOLDER%\hostinfo.txt >> %FOLDER%\hostinfo.txt
whoami >> %FOLDER%\hostinfo.txt >> %FOLDER%\hostinfo.txt
echo. >> %FOLDER%\hostinfo.txt
echo. >> %FOLDER%\hostinfo.txt
echo. >> %FOLDER%\hostinfo.txt

echo Local users on the system >> %FOLDER%\hostinfo.txt
echo ------------------------------------------------------------ >> %FOLDER%\hostinfo.txt
net users >> %FOLDER%\hostinfo.txt
echo. >> %FOLDER%\hostinfo.txt
echo. >> %FOLDER%\hostinfo.txt
echo. >> %FOLDER%\hostinfo.txt

echo Group membership, active sessions, account lock out policy >> %FOLDER%\network_config.txt
echo --------------------------- >> %FOLDER%\hostinfo.txt
net user %username% >> %FOLDER%\hostinfo.txt
net users >> %FOLDER%\hostinfo.txt
net session  >> %FOLDER%\hostinfo.txt
net accounts /domain  >> %FOLDER%\hostinfo.txt
echo. >> %FOLDER%\hostinfo.txt
echo. >> %FOLDER%\hostinfo.txt

:: Get network details

echo Available network interfaces and routing table >> %FOLDER%\network_config.txt
echo --------------------------- >> %FOLDER%\network_config.txt
ipconfig /all >> %FOLDER%\network_config.txt
echo. >> %FOLDER%\network_config.txt
echo. >> %FOLDER%\network_config.txt

echo Routing table >> %FOLDER%\network_config.txt
echo --------------------------- >> %FOLDER%\network_config.txt
route print >> %FOLDER%\network_config.txt
echo. >> %FOLDER%\network_config.txt
echo. >> %FOLDER%\network_config.txt

echo ARP cache table for all available interfaces >> %FOLDER%\network_config.txt
echo --------------------------- >> %FOLDER%\network_config.txt
arp -A >> %FOLDER%\network_config.txt
echo. >> %FOLDER%\network_config.txt
echo. >> %FOLDER%\network_config.txt

echo Active network connections >> %FOLDER%\network_config.txt
echo --------------------------- >> %FOLDER%\network_config.txt
netstat -ano >> %FOLDER%\network_config.txt
netstat -an | find /i "established" >> %FOLDER%\network_config.txt
echo. >> %FOLDER%\network_config.txt
echo. >> %FOLDER%\network_config.txt

echo Hidden, non-hidden share  >> %FOLDER%\network_config.txt
echo --------------------------- >> %FOLDER%\network_config.txt
net share >> %FOLDER%\network_config.txt
echo. >> %FOLDER%\network_config.txt
echo. >> %FOLDER%\network_config.txt

echo Hosts on the Domain and domains that the host can see >> %FOLDER%\network_config.txt
echo --------------------------- >> %FOLDER%\network_config.txt
net view >> %FOLDER%\network_config.txt
net view /domain >> %FOLDER%\network_config.txt
echo. >> %FOLDER%\network_config.txt
echo. >> %FOLDER%\network_config.txt

echo Enumerate all users on the domain >> %FOLDER%\network_config.txt
echo --------------------------- >> %FOLDER%\network_config.txt
net group "domain user" /domain
net localgroup users /domain
echo. >> %FOLDER%\network_config.txt
echo. >> %FOLDER%\network_config.txt

::Get Firewall Details
echo The netsh firewall state >> %FOLDER%\firewall_config.txt
echo --------------------------- >> %FOLDER%\firewall_config.txt
netsh firewall show state >> %FOLDER%\firewall_config.txt
netsh firewall show opmode >> %FOLDER%\firewall_config.txt
netsh firewall show port >> %FOLDER%\firewall_config.txt
echo. >> %FOLDER%\firewall_config.txt
echo. >> %FOLDER%\firewall_config.txt


echo Firewall configuration >> %FOLDER%\firewall_config.txt
echo --------------------------- >> %FOLDER%\firewall_config.txt
netsh firewall show config >> %FOLDER%\firewall_config.txt
echo. >> %FOLDER%\firewall_config.txt
echo. >> %FOLDER%\firewall_config.txt

:: Get Process and Service Details

echo Scheduled tasks >> %FOLDER%\services.txt
echo --------------------------- >> %FOLDER%\services.txt
schtasks /query /fo LIST /v >> %FOLDER%\services.txt
echo. >> %FOLDER%\services.txt
echo. >> %FOLDER%\services.txt

echo Running processes >> %FOLDER%\services.txt
echo --------------------------- >> %FOLDER%\services.txt
tasklist /SVC >> %FOLDER%\services.txt
echo. >> %FOLDER%\services.txt
echo. >> %FOLDER%\services.txt

echo System variable and paths >> %FOLDER%\services.txt
echo --------------------------- >> %FOLDER%\services.txt
set >> %FOLDER%\services.txt
echo. >> %FOLDER%\services.txt
echo. >> %FOLDER%\services.txt

echo Started windows services >> %FOLDER%\services.txt
echo --------------------------- >> %FOLDER%\services.txt
net start >> %FOLDER%\services.txt
echo. >> %FOLDER%\services.txt
echo. >> %FOLDER%\services.txt

echo Installed 3rd party drivers >> %FOLDER%\services.txt
echo --------------------------- >> %FOLDER%\services.txt
DRIVERQUERY >> %FOLDER%\services.txt
echo. >> %FOLDER%\services.txt
echo. >> %FOLDER%\services.txt



@echo Please gather the following information and put them into the folder: %FOLDER%
@echo You will need to gather the following information:
@echo Application Logs
@echo Security Logs
@echo System Logs
@echo Any malicious scripts or files found on the host
@echo Completion reports from any virus scanners/cleaners used
@echo Please press enter once you are done
pause
