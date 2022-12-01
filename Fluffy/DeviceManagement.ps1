Connect-MgGraph -Scopes DeviceManagementManagedDevices.Read.All, Directory.ReadWrite.All
 Select-MgProfile -Name beta
 $ManagedDevices = Get-MgDeviceManagementManagedDevice -Filter "Model eq 'HP EliteBook 840 G8 Notebook PC'"
    
 foreach ($ManagedDevice in $ManagedDevices){
     # Get hardware details for the device
     $ManagedDeviceHardware = (Get-MgDeviceManagementManagedDevice -ManagedDeviceId $ManagedDevice.Id -Property "hardwareInformation").HardwareInformation
    
     # Flag which basebase board the device is and xadd ExtensionAttribute per baseboard
     if (($ManagedDeviceHardware.Model -eq 'HP EliteBook 840 G8 Notebook PC') -and ($ManagedDeviceHardware.SystemManagementBiosVersion -like 'T76*')){
         Write-Output -InputObject "$($ManagedDevice.DeviceName) is a HP EliteBook 840 G8 Notebook PC with the 880D Baseboard"
         # Parameters for setting ExtensionAttribute
         $Parameters = @{
             ExtensionAttributes = @{
                 ExtensionAttribute1 = "HP EliteBook 840 G8 Notebook PC 880D"
             }
         }
         # Add ExtensionAttribute1 to Device
         Update-MgDevice -DeviceId $ManagedDevice.Id -BodyParameter $Parameters
    
     }elseif (($ManagedDeviceHardware.Model -eq 'HP EliteBook 840 G8 Notebook PC') -and ($ManagedDeviceHardware.SystemManagementBiosVersion -like 'T39*')) {
         Write-Output -InputObject "$($ManagedDevice.DeviceName) is a HP EliteBook 840 G8 Notebook PC with the 8AB3 Baseboard"
         # Parameters for setting ExtensionAttribute
         $Parameters = @{
             ExtensionAttributes = @{
                 ExtensionAttribute1 = "HP EliteBook 840 G8 Notebook PC 8AB3"
             }
         }
         # Add ExtensionAttribute1 to Device
         Update-MgDevice -DeviceId $ManagedDevice.Id -BodyParameter $Parameters
    
     }elseif (($ManagedDeviceHardware.Model -eq 'HP EliteBook 840 G8 Notebook PC') -and ($ManagedDeviceHardware.SystemManagementBiosVersion -like 'T37*')) {
         Write-Output -InputObject "$($ManagedDevice.DeviceName) is a HP EliteBook 840 G8 Notebook PC with the 8AB8 Baseboard"
         # Parameters for setting ExtensionAttribute
         $Parameters = @{
             ExtensionAttributes = @{
                 ExtensionAttribute1 = "HP EliteBook 840 G8 Notebook PC 8AB8"
             }
         }
         # Add ExtensionAttribute1 to Device
         Update-MgDevice -DeviceId $ManagedDevice.Id -BodyParameter $Parameters
     }else {
         Write-Output -InputObject "Unable to determine the Baseboard "
     }
 }