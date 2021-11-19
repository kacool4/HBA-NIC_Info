
########### Get all ESXi hosts ########################################
$vmhosts = Get-VMHost

########### Variables for NIC and HBA to store all the info ##########
$OutputNIC = @()
$OutputHBA = @()



########### Start gathering info for each ESXi #####################
foreach ($ESXHost in $vmhosts) {
  $esxcli = Get-EsxCli -vmhost $ESXHost
  $nicfirmware = $esxcli.network.nic.list()
  $fcfirmware = $esxcli.storage.san.fc.list()
  $driversoft = $esxcli.software.vib.list()


 ########## Export data for NIC and store it to $OutputNIC ############

  foreach($nicfirmwareselect in $nicfirmware)
  {
   $NetworDescription = $nicfirmwareselect.Description
   $NetworDriver = $driversoft | where { $_.name -eq ($nicfirmwareselect.Driver) }
   $NetworkName = $nicfirmwareselect.Name
   $NetworkFirmware = ($esxcli.network.nic.get($nicfirmwareselect.Name)).DriverInfo.FirmwareVersion
   $OutputNIC += "" |
   select @{N = "Hostname"; E = { $ESXHost.Name } },
   @{N = "ESXi Model"; E = { $ESXHost.Model } },
   @{N = "Driver Ver."; E = { $NetworDriver.Version } },
   @{N = "Firmware Ver."; E = { $NetworkFirmware } },
   @{N = "NIC Descr."; E = { $NetworDescription } }
   }
 

 ########## Export data for HBA and store it to $OutputHBA ############

   foreach($fcfirmwareselect in $fcfirmware){
   $fcDescription = $fcfirmwareselect.ModelDescription
   $fcDriver = $driversoft | where { $_.name -eq ($fcfirmwareselect.DriverName) }
   $fcName = $fcfirmwareselect.Adapter
   $fcFirmware = $fcfirmwareselect.FirmwareVersion
   $OutputHBA += "" |
   select @{N = "Hostname"; E = { $ESXHost.Name } },
   @{N = "ESXi Model"; E = { $ESXHost.Model } },
   @{N = "Driver Ver."; E = { $fcDriver.Version } },
   @{N = "Firmware Ver."; E = { $fcFirmware } },
   @{N = "HBA Descr."; E = { $fcDescription } }
 }
}

########## Export data from Nic and HBA to 2 different files############
$OutputHBA | Export-Csv -Path 'info_hba.csv'
$OutputNIC | Export-Csv -Path 'info_nic.csv'
