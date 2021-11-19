# HBA and Network info for Drivers and Firmware


## Scope:
Script that exports info about the drivers and firmware on all ESXi's that are part of a vCenter.

## Requirements:
* Windows Server 2012 and above // Windows 10
* Powershell 5.1 and above
* PowerCLI either standalone or import the module in Powershell (Preferred)

## How to Run it
 First you need to connect to vCenter from powershell // powercli
 ```powershell
 PS> Connect-VIServer <FQDN or IP> 
 ```
 
 Run the script
 ```powershell
 # make sure to change the directory in case you are not running the script from C:\
 PS> C:\HBA_NIC_INFO.ps1 
 ```
The script will run and create 2 CSV files. One with all HBA info (HBA_Info.csv) and the other for all NIC info (NIC_Info.csv)  

- HBA Info
  
![Alt text](/screenshots/hba.jpg?raw=true "Info about HBA firmware // driver version")
 

- NIC Info
 
![Alt text](/screenshots/nic.jpg?raw=true "Info about Nic firmware // driver version")


## Frequetly Asked Questions:
* When I am executing the script it gives you an error "vCenter not found".
   > Before you execute the script you need first to be connected on a vCenter Server.
   ```powershell
   PS> Connect-VIServer <vCenter-IP-FQDN>
   ```
   
* When I run the script it gives me error on Excel commands
  > You are missing the Excel module. You need to import it prior of running the script.
  ```powershell 
  PS> Install-Module -Name ImportExcel
  ```
