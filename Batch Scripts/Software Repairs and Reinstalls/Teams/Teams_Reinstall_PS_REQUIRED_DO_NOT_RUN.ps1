#-------------------------------------------------------------------------------------------------------------
#	INITIALIZATION
#-------------------------------------------------------------------------------------------------------------
cd C:\
Stop-Process -Name "Teams" -Force -ErrorAction SilentlyContinue

$RawUserName = (Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -Property UserName)
$UserName = $RawUserName.Username.split("\"" ", 2).GetValue(1).ToString().Replace('}','')
$DownloadsFolderPath = $("C:\Users\$Username\Downloads")
$TeamsInstallerURL = "https://go.microsoft.com/fwlink/p/?LinkID=2187327&clcid=0x409&culture=en-us&country=US"


function unInstallTeams($path)
{

 $clientInstaller = "$($path)\Update.exe"

 try 
 {
    $process = Start-Process -FilePath "$clientInstaller" "--uninstall /s" -PassThru -Wait -ErrorAction STOP

    if($process.ExitCode -eq 0){Write-Host "Teams successfully removed at: $clientInstaller" -ForegroundColor DarkYellow}
 }

 catch 
 {
    Write-Host ""
    Write-Host "ERROR:Could not find or execute 'Update.exe' at: $clientInstaller." -ForegroundColor Red
    Write-Host "Uninstallation failed." -ForegroundColor Red
 }

}

#-------------------------------------------------------------------------------------------------------------
#	REMOVE TEAMS MACHINE WIDE INSTALLER
#-------------------------------------------------------------------------------------------------------------

Write-Host "" 
Write-Host "Checking for Teams Machine-wide Installer..." -ForegroundColor Yellow


$MachineWide = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "Teams Machine-Wide Installer"}

if ($MachineWide) 
{
	$MachineWide.Uninstall()
	Write-Host "Teams Machine-wide Installer successfully removed." -ForegroundColor DarkYellow
} 
else 
{
	Write-Host "Teams Machine-wide Installer not found. Skipping." -ForegroundColor DarkYellow
}

#-------------------------------------------------------------------------------------------------------------
#	REMOVE TEAMS
#-------------------------------------------------------------------------------------------------------------

$localAppData = "$("C:\Users\$Username\AppData\Local\Microsoft\Teams")"
$programData = "$($env:ProgramData)\$($Username)\Microsoft\Teams"

Write-Host "---" -ForegroundColor Green
Write-Host "Checking for Teams installation..." -ForegroundColor Yellow

# Check if Teams is installed in Program data or User local appdata
if (Test-Path "$($localAppData)\Current\Teams.exe")
 {
 unInstallTeams($localAppData)
 }

elseif (Test-Path "$($programData)\Current\Teams.exe")
 {
 unInstallTeams($programData)
 }

else 
{
 Write-Host "Teams installation not found. Continuing reinstall process." -ForegroundColor DarkYellow
}

Write-Host "-------------------------------------------------------------------------" -ForegroundColor Green



#-------------------------------------------------------------------------------------------------------------
#	REMOVE ALL CACHE FOLDERS
#-------------------------------------------------------------------------------------------------------------

## Loop through cache folders for the user and remove files.
Write-Host "Attempting to clear Teams cache files..." -ForegroundColor Yellow

try {
Get-ChildItem -Path "C:\Users\$Username\AppData\Roaming\Microsoft\Teams\*" -Directory | `
	Where-Object Name -in ('application cache','blob_storage','databases','GPUcache','IndexedDB','Local Storage','tmp') | `
	ForEach {Remove-Item $_.FullName -Recurse -Force}

    Write-Host ""
    Write-Host "Teams cache process complete." -ForegroundColor DarkYellow
    }
catch {
	   Write-Error "Cache deletion has encountered an unknown error. Cache removal aborted."
 	   Write-Error $_.Exception.Message
      }

Write-Host "-------------------------------------------------------------------------" -ForegroundColor Green

#-------------------------------------------------------------------------------------------------------------
#	INSTALL TEAMS
#-------------------------------------------------------------------------------------------------------------
Write-Host "Retrieving MS Teams install file from web..." -ForegroundColor Yellow
try {
	 (New-Object System.Net.WebClient).DownloadFile($TeamsInstallerURL, $DownloadsFolderPath + "\TeamsInstaller.exe")
	 Write-Host "Download successful. Executing teams installer." -ForegroundColor Green
	 Start-Process -FilePath (-join($DownloadsFolderPath,"\TeamsInstaller.exe")) -ArgumentList "/S" -PassThru
    }
catch {
	   Write-Error "Error Attempting to download Teams installer. Please check internet or website connectivity issues and try again later."
	   Write-Error $_.Exception.Message
       Write-Host "You can also go directly to the Teams install page here: https://www.microsoft.com/en-us/microsoft-teams/download-app#desktopAppDownloadregion" -ForegroundColor Magenta
       }

Write-Host ""
Write-Host "Teams reinstall Script complete." -ForegroundColor DarkYellow
