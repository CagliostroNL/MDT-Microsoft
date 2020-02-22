<# 
.DESCRIPTION
Clean-up script die uitgevoerd wordt na dat reference image is gemaakt. 
Wordt uitgevoerd via scheduled tasks, na de make referece image scheduled task.

.NOTES
    Version: 1.0
    Author:Cagliostro
    Creation Date: 20-2-2020
#>


$VMHost = "HYPERV00"
$VMGuestName = "REFVM"
$RefBootName = "ZTI Reference Image"
$VHDPath = "C:\Users\Public\Documents\Hyper-V\Virtual Hard Disks\REF.VHDX"

Invoke-Command -ComputerName $VMHost -ScriptBlock { Set-WdsBootImage $Using:RefBootName -ImageName  -DisplayOrder "500000"}
Invoke-Command -ComputerName $VMHost -ScriptBlock {Remove-VM -Name $Using:VMGuestName -Force} 
Invoke-Command -ComputerName $VMHost -ScriptBlock {Remove-Item -Path $Using:VHDPath}
