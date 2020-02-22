<# 
.DESCRIPTION


.NOTES
    Version: 1.0
    Author: Cagliostro
    Creation Date: 22-2-2020
#>


#-----------------Module MDT-------------------
Add-PSSnapin -Name Microsoft.BDD.PSSnapIn 

#--------------------Variables-----------------
$BuildShare = "E:\MDTBuildLab\Captures"
$LastReferenceImage = Get-ChildItem -Path $BuildShare | Sort-Object LastWriteTime | Select-Object -Last 1
$Foldername = $LastReferenceImage.Name.Replace(".wim", "")
$OSPATH= "Operating Systems"
$DeployShares = @("E:\MDTZTI", "E:\MDTProductie")

#--------------------Task-----------------
ForEach ($Share in  $DeployShares){
    New-PSDrive -Name "DS002" -PSProvider MDTProvider -Root $Share
    Import-MDTOperatingSystem -Path "DS002:$OSPATH" -SourceFile $LastReferenceImage.FullName -DestinationFolder $Foldername
    $GetLastFile = (Get-ChildItem "DS002:$OSPATH" | Sort-Object LastWriteTime | Select-Object -Last 1).Name
    $GetGuid = (Get-ItemProperty "DS002:$OSPATH\$GetLastFile").guid
    $Share = $Share.Replace("E:\", "")
    Add-Content -path "C:\Users\Administrator\Desktop\$Share.txt" $GetGuid
    Remove-PSDrive "DS002"   
}