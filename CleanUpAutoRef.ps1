<# 
.DESCRIPTION
Clean-up script die uitgevoerd wordt na dat reference image is gemaakt. 
Wordt uitgevoerd via scheduled tasks, na de make referece image scheduled task.

.NOTES
    Author: https://github.com/CagliostroNL
    Creation Date: 20-2-2020
#>


#--------------------Variables-----------------
$VMHost = "HYPERV00"
$VMGuestName = "REFVM"
$RefBootName = "ZTI Reference Image"
$VHDPath = "C:\Users\Public\Documents\Hyper-V\Virtual Hard Disks\REF.VHDX"
$DesktopPath = @("C:\Users\Administrator\Desktop\MDTZTI.txt", "C:\Users\Administrator\Desktop\MDTProductie.txt")

#--------------------Task-----------------
Set-WdsBootImage  -Architecture x64 -ImageName $RefBootName -DisplayOrder 500000
Invoke-Command -ComputerName $VMHost -ScriptBlock {Remove-VM -Name $Using:VMGuestName -Force} 
Invoke-Command -ComputerName $VMHost -ScriptBlock {Remove-Item -Path $Using:VHDPath}

foreach ($item in $DesktopPath) {
    Remove-Item -Path $item
}

