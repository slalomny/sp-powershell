param(
	[string]$SiteUrl,
    [string]$LocalRootPath,  #E:\GIT\Slalom-Provisioning\content
    [string]$TargetURL       #/Style Library/JnJ
)

$ver = $host | Select-Object version
if ($ver.Version.Major -gt 1) {
    $host.Runspace.ThreadOptions = "ReuseThread"
}

#Import-Module SharePointPnPPowerShellOnline -WarningAction SilentlyContinue

function Run () {
    Write-Host "Starting [UPLOADS] deployment from $LocalRootPath"

    Connect-SPOnline -Url $SiteUrl -UseWebLogin ##-Credentials (Get-Credential) -ErrorAction Stop
    $web = Get-SPOWeb
    [string]$serverRelativeUrl = $web.ServerRelativeUrl

    $folders = Get-ChildItem -Path $LocalRootPath -Directory -Recurse

    Write-Host $TargetURL
    Write-Host $serverRelativeUrl

    foreach($folder in $folders) {
        [string]$FolderName = $folder.Name
        [string]$FolderPath = $folder.FullName
        [string]$spoFolderUrl = $FolderPath.Replace($LocalRootPath, "").Replace("\", "/")
        $spoFolderUrl = $TargetURL + $spoFolderUrl

        Write-Host "Processing.... $spoFolderUrl"
        Ensure-SPOFolder -SiteRelativePath $spoFolderUrl 

        $files = $folder.GetFiles()

        foreach($file in $files) {
            [string]$filePath = $file.FullName

            Write-Host "  >> processing file.... $filePath"
            Add-SPOFile -Path $filePath -Folder $spoFolderUrl -Checkout 
        }

    }
}

Run