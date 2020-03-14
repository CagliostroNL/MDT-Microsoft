<# 
.DESCRIPTION
Automatiseert het maken van een Windows reference image.

.NOTES
    Author: https://github.com/CagliostroNL
    Creation Date: 20-2-2020
#>

$VMHost = "HYPERV00"
$VMGuestName = "REFVM"
$VMSize = 40GB 
$VMMem = 3GB
$VMNetAdapter = "LegacyNetworkAdapter"
$VMSwitch = "Deploy_HYPERV"
$VHDPath = "C:\Users\Public\Documents\Hyper-V\Virtual Hard Disks\REF.VHDX"

Invoke-Command -ComputerName $VMHost -ScriptBlock {Set-WdsBootImage  -ImageName "ZTI Reference Image" -DisplayOrder "300000"}
Invoke-Command -ComputerName $VMHost -ScriptBlock { New-VM -Name $Using:VMGuestName -MemoryStartupBytes $Using:VMMem -NewVHDPath $Using:VHDPath -NewVHDSizeBytes $Using:VMSize -BootDevice $Using:VMNetAdapter -SwitchName $Using:VMSwitch }
Invoke-Command -ComputerName $VMHost -ScriptBlock {Set-VMBios $Using:VMGuestName -StartupOrder  @("IDE", "LegacyNetworkAdapter", "CD","Floppy")}
Invoke-Command -ComputerName  $VMHost -ScriptBlock {Start-VM -Name $Using:VMGuestName}
