$printdate = ((Get-Date).ToString('MM/dd/yyyy'))
$sampleindex = 'C:\Sutter Sorting\CommerceIndex_LtrIDCards_20181016210248.csv'

#Import Index for sorting and filling in date
Import-CSV -Path $sampleindex | `
#Add Date to date printed, sort by parent correspondence ID and correspondence id and then create a new csv 
ForEach-Object { $_.'Date Printed' = "$printdate"; return $_ } | `
 Sort-Object -Property @{Expression = "Parent Correspondence ID"; Ascending = $True}, `
  @{Expression = "Correspondence ID"; Ascending = $True} | `
 Export-CSV -Path "C:\Sutter Sorting\newcsv.csv" -NoTypeInformation -Force

$newcsv = import-csv -path "c:\sutter sorting\newcsv.csv"
$newcsv | ForEach { $_.PSObject.Properties.Remove('Is Updatable'),$_.PSObject.Properties.Remove('Estimated Delivery Date'),$_.PSObject.Properties.Remove('Testing Comments'),$_.PSObject.Properties.Remove('Sweep Type') } 
$newcsv | export-csv -path "C:\sutter sorting\$todaysdate-joblist.csv" -Append -NoTypeInformation
Add-Content -Path "C:\sutter sorting\$todaysdate-joblist.csv"  -Value '"","","","","","","","","","","","ENDOFBATCH"'
