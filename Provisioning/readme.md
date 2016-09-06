# sf.upload.ps1
Replicates directory structure and uploads files to respective folders on SharePoint Online from local directory. 

#### Prerequisites
Install PowerShell PnP commandlets from [PowerShell PnP](https://github.com/OfficeDev/PnP-PowerShell)

#### Syntax
```sh
$ ./sf.upload.ps1 -SiteUrl "https://tenant.sharepoint.com/sites/site1" -LocalRootPath "E:\Slalom-Provisioning\content" -TargetURL "/Style Library/JnJ"
```

#### Parameters
Parameter|Type|Required|Description
---------|----|--------|-----------
|SiteUrl|string|True|SharePoint site url.|
|LocalRootPath|string|True|Local directory path to uploaded.|
|TargetURL|string|True|Document library url|
