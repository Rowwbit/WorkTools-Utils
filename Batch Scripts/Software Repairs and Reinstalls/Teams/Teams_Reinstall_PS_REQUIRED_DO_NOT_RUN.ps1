#-------------------------------------------------------------------------------------------------------------
#	INITIALIZATION
#-------------------------------------------------------------------------------------------------------------
$DownloadsFolderPath = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$TeamsInstallerURL = "https://go.microsoft.com/fwlink/p/?LinkID=2187327&clcid=0x409&culture=en-us&country=US"

function unInstallTeams($path) {

 $clientInstaller = "$($path)\Update.exe"

 try {

 $process = Start-Process -FilePath "$clientInstaller" "--uninstall /s" -PassThru -Wait -ErrorAction STOP

 if ($process.ExitCode -ne 0)

 {

 Write-Error "UnInstallation failed with exit code $($process.ExitCode)."

 }

 }

 catch {

 Write-Error $_.Exception.Message

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

$localAppData = "$($env:LOCALAPPDATA)\Microsoft\Teams"

$programData = "$($env:ProgramData)\$($env:USERNAME)\Microsoft\Teams"

Write-Host "---" -ForegroundColor Green
Write-Host "Checking for Teams installation..." -ForegroundColor Yellow


If (Test-Path "$($localAppData)\Current\Teams.exe")

{

 unInstallTeams($localAppData)
 Write-Host "Teams successfully removed in LocalAppData." -ForegroundColor DarkYellow
}

elseif (Test-Path "$($programData)\Current\Teams.exe") {

 unInstallTeams($programData)
 Write-Host "Teams successfully removed in ProgramData." -ForegroundColor DarkYellow
}

else {

 Write-Host "Teams installation not found. Continuing reinstall process." -ForegroundColor DarkYellow
}

Write-Host "-------------------------------------------------------------------------" -ForegroundColor Green



#-------------------------------------------------------------------------------------------------------------
#	REMOVE ALL CACHE FOLDERS
#-------------------------------------------------------------------------------------------------------------

## Remove the all users' cache. This reads all user subdirectories in each user folder matching
## all folder names in the cache and removes them all

Write-Host "Attempting to clear Teams cache files..." -ForegroundColor Yellow

try {
Get-ChildItem -Path "C:\Users\*\AppData\Roaming\Microsoft\Teams\*" -Directory | `
	Where-Object Name -in ('application cache','blob_storage','databases','GPUcache','IndexedDB','Local Storage','tmp') | `
	ForEach {Remove-Item $_.FullName -Recurse -Force}
    }

catch {
	   Write-Error "Cache deletion has encountered an unknown error. Cache removal aborted."
	   Write-Error "This error occured in section A. (C:\Users\*\AppData\Roaming\Microsoft\Teams\*)"
 	   Write-Error $_.Exception.Message
      }


## Remove every user's cache. This reads all subdirectories in the $env:APPDATA\Microsoft\Teams folder matching
## all folder names in the cache and removes them all
try {
Get-ChildItem -Path "$env:APPDATA\Microsoft\Teams\*" -Directory | `
	Where-Object Name -in ('application cache','blob storage','databases','GPUcache','IndexedDB','Local Storage','tmp') | `
	ForEach {Remove-Item $_.FullName -Recurse -Force}
    }

catch {
	   Write-Error "Cache deletion has encountered an unknown error. Cache removal aborted."
	   Write-Error "This error occured in section B. ($env:APPDATA\Microsoft\Teams\*)"
 	   Write-Error $_.Exception.Message
      }

Write-Host ""
Write-Host "Teams cache process complete." -ForegroundColor DarkYellow
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
