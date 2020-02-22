<# 
.DESCRIPTION
Automatiseert het maken van een Windows reference image.
Uit te voeren via Scheduled tasks, script wdsproback.ps1 uitvoeren via scheduled task na ongeveer +- 3 uur om wds priority
terug te zetten.

.NOTES
    Version: 1.0
    Author: Cagliostro
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