#Set Date variable for inserting into date sent
$printdate = ((Get-Date).ToString('MM/dd/yyyy'))
$targetindex = get-item -path "C:\Sutter Sorting\commerceindex*.csv"

#Import Index to be edited
Import-CSV -Path $targetindex | `
#Add Date to date printed, sort by parent correspondence ID and correspondence id and then create a new csv 
ForEach-Object { $_.'Date Printed' = "$printdate"; return $_ } | ` Sort-Object -Property @{Expression = "Parent Correspondence ID"; Ascending = $True}, @{Expression = "Correspondence ID"; Ascending = $True} | Export-CSV -Path "indexwithdate.csv" -NoTypeInformation