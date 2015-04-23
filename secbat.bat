::
:: Windows forensics
::
:: Please read the README.txt file for more information
::
@echo off

:: Make Results Directory with time/date stamp
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)

set FOLDER="%mydate%_%mytime%"

mkdir %FOLDER%

:: Get Host and User Info 

echo ------------------------------------------------------------ >> %FOLDER%\hostinfo.txt
echo OS Details >> %FOLDER%\hostinfo.txt
echo ------------------------------------------------------------ >> %FOLDER%\hostinfo.txt
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" >> %FOLDER%\hostinfo.txt
hostname >> %FOLDER%\hostinfo.txt >> %FOLDER%\hostinfo.txt
whoami >> %FOLDER%\hostinfo.txt >> %FOLDER%\hostinfo.txt


echo ------------------------------------------------------------ >> %FOLDER%\netusers.txt
echo Local users on the system >> %FOLDER%\netusers.txt 
echo ------------------------------------------------------------ >> %FOLDER%\netusers.txt
net users >> %FOLDER%\netusers.txt

echo ------------------------------------------------------------ >> %FOLDER%\netaccounts.txt
echo Group membership, active sessions, account lock out policy >> %FOLDER%\netaccounts.txt
echo ------------------------------------------------------------ >> %FOLDER%\netaccounts.txt
net accounts /domain  >> %FOLDER%\netaccounts.txt


:: Get network details
echo ------------------------------------------------------------ > %FOLDER%\ipconfig-all.txt
echo Available network interfaces and routing table >> %FOLDER%\ipconfig-all.txt
echo ------------------------------------------------------------ >> %FOLDER%\ipconfig-all.txt
ipconfig /all >> %FOLDER%\ipconfig-all.txt


echo ------------------------------------------------------------ > %FOLDER%\routeprint.txt
echo Routing table >> %FOLDER%\routeprint.txt
echo ------------------------------------------------------------ >> %FOLDER%\routeprint.txt
route print >> %FOLDER%\routeprint.txt


echo ------------------------------------------------------------ >> %FOLDER%\arp-a.txt
echo ARP cache table for all available interfaces >> %FOLDER%\arp-a.txt
echo ------------------------------------------------------------ >> %FOLDER%\arp-a.txt
arp -A >> %FOLDER%\arp-a.txt


echo ------------------------------------------------------------ > %FOLDER%\netstat.txt
echo Active network connections >> %FOLDER%\netstat.txt
echo netstat -ano >> %FOLDER%\netstat.txt
echo ------------------------------------------------------------ >> %FOLDER%\netstat.txt
netstat -ano >> %FOLDER%\netstat.txt
echo ------------------------------------------------------------ >> %FOLDER%\netstat.txt
echo Show Established Connections>> %FOLDER%\netstat.txt
echo ------------------------------------------------------------ >> %FOLDER%\netstat.txt
netstat -an | find /i "established" >> %FOLDER%\netstat.txt



echo ------------------------------------------------------------ > %FOLDER%\netshare.txt
echo Hidden, non-hidden share  >> %FOLDER%\netshare.txt
echo ------------------------------------------------------------ >> %FOLDER%\netshare.txt
net share >> %FOLDER%\netshare.txt


::Get Firewall Details
echo ------------------------------------------------------------ > %FOLDER%\firewall_config.txt
echo netsh firewall show state >> %FOLDER%\firewall_config.txt
netsh firewall show state >> %FOLDER%\firewall_config.txt
echo ------------------------------------------------------------ >> %FOLDER%\firewall_config.txt
echo netsh firewall show opmode >> %FOLDER%\firewall_config.txt
netsh firewall show opmode >> %FOLDER%\firewall_config.txt
echo ------------------------------------------------------------ >> %FOLDER%\firewall_config.txt
echo netsh firewall show port >> %FOLDER%\firewall_config.txt
echo ------------------------------------------------------------ >> %FOLDER%\firewall_config.txt
netsh firewall show port >> %FOLDER%\firewall_config.txt


echo ------------------------------------------------------------ >> %FOLDER%\firewall_config.txt
echo netsh firewall show config >> %FOLDER%\firewall_config.txt
echo ------------------------------------------------------------ >> %FOLDER%\firewall_config.txt
netsh firewall show config >> %FOLDER%\firewall_config.txt


:: Get Process and Service Details

echo ------------------------------------------------------------ > %FOLDER%\scheduledtasks.txt
echo Scheduled tasks >> %FOLDER%\scheduledtasks.txt
echo schtasks /query /fo LIST /v >> %FOLDER%\scheduledtasks.txt
echo ------------------------------------------------------------ >> %FOLDER%\scheduledtasks.txt
schtasks /query /fo LIST /v >> %FOLDER%\scheduledtasks.txt


echo ------------------------------------------------------------ >> %FOLDER%\processes.txt
echo Running processes >> %FOLDER%\processes.txt
echo tasklist /SVC >> %FOLDER%\processes.txt
echo ------------------------------------------------------------ >> %FOLDER%\processes.txt
tasklist /SVC >> %FOLDER%\processes.txt


echo ------------------------------------------------------------ >> %FOLDER%\systemvariables.txt
echo System variable and paths >> %FOLDER%\systemvariables.txt
echo ------------------------------------------------------------ >> %FOLDER%\systemvariables.txt
set >> %FOLDER%\systemvariables.txt


echo ------------------------------------------------------------ >> %FOLDER%\netstart.txt
echo Started windows services >> %FOLDER%\netstart.txt
echo net start >> %FOLDER%\netstart.txt
echo ------------------------------------------------------------ >> %FOLDER%\netstart.txt
net start >> %FOLDER%\netstart.txt


echo ------------------------------------------------------------ >> %FOLDER%\driverquery.txt
echo Installed 3rd party drivers >> %FOLDER%\driverquery.txt
echo ------------------------------------------------------------ >> %FOLDER%\driverquery.txt
DRIVERQUERY >> %FOLDER%\driverquery.txt


echo ------------------------------------------------------------ >> %FOLDER%\run_reg_keys.txt
echo Registry Run Keys >> %FOLDER%\run_reg_keys.txt
echo ------------------------------------------------------------ >> %FOLDER%\run_reg_keys.txt
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run  >>  %FOLDER%\run_reg_keys.txt
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Runonce  >>  %FOLDER%\run_reg_keys.txt
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunonceEx >>  %FOLDER%\run_reg_keys.txt
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU >> %FOLDER%\run_reg_keys.txt
reg query HKLM\Software\Classes\Exefile\Shell\Open\Command >> %FOLDER%\run_reg_keys.txt
reg query HKEY_CLASSES_ROOT\Exefile\Shell\Open\Command >> %FOLDER%\run_reg_keys.txt\
reg query HKCU\Software\Microsoft\Internet Explorer\TypedURLs >>  %FOLDER%\run_reg_keys.txt

