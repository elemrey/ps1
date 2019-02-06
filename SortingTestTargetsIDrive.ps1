#Set variable todaysdate in order to name folders by current date
$todaysdate = ((Get-Date).ToString('MM-dd-yy'))
#Set variable due in order to name folders by current date
$duedate = (((Get-Date).adddays(4)).ToString('MM-dd-yy'))
#Prompt user for batch number to append to folder
$batchid = Read-host -Prompt 'Please assign a batch number'
#Prompt user to point script at correct files
$batchname = Read-host -Prompt 'Copy and paste the folder name for processing'
#Storing a string that combines batchname and ID
$batchidname = "$batchid`_$batchname"
#Set Date variable for inserting into date sent

#Extract Zip file in X drive
Expand-Archive x:\$batchname\$batchname.zip -DestinationPath x:\$batchname\$batchname

#Rename extracted folder to include batch number
rename-item -path x:\$batchname\$batchname\$batchname -NewName $batchidname
#This segment is meant to add the date to, and sort the index file
#Set Variable for printed Date
$printdate = ((Get-Date).ToString('MM/dd/yyyy'))
#Set Path to Index file
$targetindex = get-item -path "x:\$batchname\$batchname\$batchidname\commerceindex*.csv"
#Store Sutter Index File name
$cindexfilename = (get-itemproperty -path "x:\$batchname\$batchname\$batchidname\commerceindex*.csv").Name


mkdir I:\'Order Preparation'\'Sutter Health'\'Current Job Indices'\$todaysdate-index\ -ErrorAction SilentlyContinue
mkdir I:\'Order Preparation'\'Sutter Health'\'Current Job Indices'\$todaysdate-index\$batchidname -ErrorAction SilentlyContinue


#Import Index for sorting and filling in date
Import-CSV -Path $targetindex | `
#Add Date to date printed, sort by parent correspondence ID and correspondence id and then create a new csv 
ForEach-Object { $_.'Date Printed' = "$printdate"; return $_ } | ` Sort-Object -Property @{Expression = "Parent Correspondence ID"; Ascending = $True}, @{Expression = "Correspondence ID"; Ascending = $True} | Export-CSV -Path "I:\Order Preparation\Sutter Health\Current Job Indices\$todaysdate-index\$batchidname\$cindexfilename" -NoTypeInformation -Force


#Make new folder to move items into with todays date, item type, and batchID

mkdir I:\'Files to Digital Press'\'SUTTER HEALTH'\$todaysdate-letters\ -ErrorAction SilentlyContinue
mkdir I:\'Files to Digital Press'\'SUTTER HEALTH'\$todaysdate-letters\$batchidname -ErrorAction SilentlyContinue
mkdir I:\1-PREFLIGHT\SUTTER_ID_CARDS\$todaysdate-cards\ -ErrorAction SilentlyContinue
mkdir I:\1-PREFLIGHT\SUTTER_ID_CARDS\$todaysdate-cards\$batchidname -ErrorAction SilentlyContinue


#Take and move items from the extracted path to their destinations
Get-ChildItem -path x:\$batchname\$batchname\$batchidname\* -include *CommerceIndex* | move-item -Destination 'C:\Sutter Sorting\sources'
#Move all items with letter in the name
Get-ChildItem -path X:\$batchname\$batchname\$batchidname\* -include *letter* | move-item -destination I:\'Files to Digital Press'\'SUTTER HEALTH'\$todaysdate-letters\$batchidname
#Move all items with notice in the name
Get-ChildItem -path X:\$batchname\$batchname\$batchidname\* -include *notice* | move-item -destination I:\'Files to Digital Press'\'SUTTER HEALTH'\$todaysdate-letters\$batchidname
#Move all items with notification in the name
Get-ChildItem -path X:\$batchname\$batchname\$batchidname\* -include *notification* | move-item -destination I:\'Files to Digital Press'\'SUTTER HEALTH'\$todaysdate-letters\$batchidname
#Move al items with coverage in the name
Get-ChildItem -path X:\$batchname\$batchname\$batchidname\* -include *Coverage* | move-item -destination I:\'Files to Digital Press'\'SUTTER HEALTH'\$todaysdate-letters\$batchidname
#Move all items with form in the name
Get-ChildItem -path X:\$batchname\$batchname\$batchidname\* -include *form* | move-item -destination I:\'Files to Digital Press'\'SUTTER HEALTH'\$todaysdate-letters\$batchidname
#Move all items with form in the name
Get-ChildItem -path X:\$batchname\$batchname\$batchidname\* -include *claim* | move-item -destination I:\'Files to Digital Press'\'SUTTER HEALTH'\$todaysdate-letters\$batchidname
#Move all items with premium billing in the name
Get-ChildItem -path X:\$batchname\$batchname\$batchidname\* -include *premium_billing* | move-item -destination I:\'Files to Digital Press'\'SUTTER HEALTH'\$todaysdate-letters\$batchidname
#Move items with id_card in the name unless they have letter in the name
Get-ChildItem -path X:\$batchname\$batchname\$batchidname\* -exclude *letter* -include *id_card* | move-item -destination I:\1-PREFLIGHT\SUTTER_ID_CARDS\$todaysdate-cards\$batchidname

$lettersinbatch = (Get-ChildItem -path I:\'Files to Digital Press'\'SUTTER HEALTH'\$todaysdate-letters\$batchidname | measure-object).count
write-output "Batch number $batchid has $lettersinbatch letters."
$cardsinbatch = (Get-childItem -path I:\1-PREFLIGHT\SUTTER_ID_CARDS\$todaysdate-cards\$batchidname | `
 measure-object).count
write-output "Batch number $batchid has $cardsinbatch member ID cards."
$orderforminfo = "$batchidname `r`n letters: $lettersinbatch `r`n Member ID Cards: $cardsinbatch" | `
out-file -filepath "C:\sutter sorting\BatchCount$todaysdate.txt" -append

import-csv 'C:\Sutter Sorting\datamerge.csv'
$datamerge = @(
[pscustomobject]@{
"Date" = $todaysdate
"Folder-Name" = $batchidname
"No-Letters" = $lettersinbatch
"No-Cards" = $cardsinbatch
"Due-date" = $duedate
}
)
$datamerge | Export-csv -path "C:\Sutter Sorting\BatchCount$todaysdate.csv" -Append -notypeinfo

#This Section of the script generates a CSV file that is ready to be copied to the jobs list, 

$sutterjobslist = import-csv -path "I:\Order Preparation\Sutter Health\Current Job Indices\$todaysdate-index\$batchidname\$cindexfilename"
$sutterjobslist | ForEach { $_.PSObject.Properties.Remove('Is Updatable'),$_.PSObject.Properties.Remove('Estimated Delivery Date'),$_.PSObject.Properties.Remove('Testing Comments'),$_.PSObject.Properties.Remove('Sweep Type') } 
$sutterjobslist | export-csv -path "I:\Sutter Batch Processing\$todaysdate-sutterjoblist.csv" -Append -NoTypeInformation
Add-Content -Path "I:\Sutter Batch Processing\$todaysdate-sutterjoblist.csv"  -Value '"","","","","","","","","","","","ENDOFBATCH"'
