<# 
.DESCRIPTION


.NOTES
    Author: https://github.com/CagliostroNL
    Creation Date: 22-2-2020
#>

#--------------------Variables-----------------
$BuildShare = "E:\MDTBuildLab\Captures"
$LastReferenceImage = Get-ChildItem -Path $BuildShare | Sort-Object LastWriteTime -Descending | Select-Object -First 1
$Foldername = $LastReferenceImage.Name.Replace(".wim", "")
$OSPATH= "Operating Systems"
$DeployShares = @("E:\MDTZTI", "E:\MDTProductie")

#--------------------Task-----------------
ForEach ($Share in  $DeployShares){
    New-PSDrive -Name "DS002" -PSProvider MDTProvider -Root $Share
    Import-MDTOperatingSystem -Path "DS002:$OSPATH" -SourceFile $LastReferenceImage.FullName -DestinationFolder $Foldername
    Start-Sleep -Second 30
    $GetLastFile = (Get-ChildItem "DS002:$OSPATH" | Sort-Object { $_.CreatedTime -as [datetime]} | Select-Object -First 1).Name
    Write-Host $GetLastFile
    $GetGuid = (Get-ItemProperty "DS002:$OSPATH\$GetLastFile").guid
    $Share = $Share.Replace("E:\", "")
    Add-Content -path "C:\Users\Administrator\Desktop\$Share.txt" $GetGuid
    Remove-PSDrive "DS002" 
}
