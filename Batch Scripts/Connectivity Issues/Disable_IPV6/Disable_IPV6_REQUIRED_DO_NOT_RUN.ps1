
# Grab all adapters to sort through later
$AdaptersArry = Get-NetAdapter "*"
Write-Host "All network adapters on current machine:"
Get-NetAdapter
Write-Host "----------------------------------------------------"

# Sort through the global AdaptersArry and get only the names of adapters
function GetAllAdapterNames() 
{
    $arrayList = @()
    foreach($adapterName in $AdaptersArry.Name)
    {
        $arrayList += ,$adapterName
    }
    return $arrayList
}

# Loop through all adapter names and disable IPV6 until count equals the number of adapters
$AdapterNamesArry = GetAllAdapterNames
$Index = 0

while ($Index -ne $AdapterNamesArry.Count)
{
    
    Write-Host "Attempting to disable IPV6 on: $($AdapterNamesArry[$($Index)]) adapter."
    try{Disable-NetAdapterBinding -Name "$($AdapterNamesArry[$Index])" -ComponentID ms_tcpip6}
    catch
    {
        Write-Host "Error on: $($AdapterNamesArry[$Index])"
        Write-Error $_.Exception.Message
    }
    $Index++
}

PAUSE