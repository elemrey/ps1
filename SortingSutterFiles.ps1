$batchesleft = read-host "How many batches are we processing?"



while ($batchesleft -gt 0)
{
#Set variable todaysdate in order to name folders by current date
$todaysdate = ((Get-Date).ToString('MM-dd-yy'))


#Prompt user for batch number to append to folder
#$batchid = Read-host -Prompt 'Please assign a batch number'

$bnum = Import-Csv -path 'I:\Sutter Batch Processing\bnum.csv'
[int]$bnum.lastbatch +=1
$batchid = $bnum.lastbatch
write-output "Current Batch numbers is $batchid"

#Prompt user to point script at correct files
$batchname = Read-host -Prompt 'Copy and paste the folder name for processing'
#Capture batch notes
$batchnotes = ""
$batchnotes = Read-host -Prompt 'Copy and paste notes if any'

#Storing a string that combines batchname and ID
$batchidname = "$batchid`_$batchname"
#Set Date variable for inserting into date sent

#Extract Zip file in X drive
Expand-Archive x:\$batchname\$batchname.zip -DestinationPath x:\$batchname\$batchname

#Rename extracted folder to include batch number
rename-item -path x:\$batchname\$batchname\$batchname -NewName $batchidname
#This segment is meant to add the date and sort the index file
#Set Variable for printed Date
$printdate = ((Get-Date).ToString('MM/dd/yyyy'))
#Set Path to Index file
$targetindex = get-item -path "x:\$batchname\$batchname\$batchidname\commerceindex*.csv"
#Sutter Index FileName
$sutterindex = (get-itemproperty -path "x:\$batchname\$batchname\$batchidname\commerceindex*.csv").Name

#Make Index folder
mkdir Y:\'Order Preparation'\'Sutter Health'\'Current Job Indices'\$todaysdate-index\ -ErrorAction SilentlyContinue
mkdir Y:\'Order Preparation'\'Sutter Health'\'Current Job Indices'\$todaysdate-index\$batchidname -ErrorAction SilentlyContinue


#Import Index for sorting and filling in date
Import-CSV -Path $targetindex | `
#Add Date to date printed, sort by parent correspondence ID and correspondence id and then create a new csv 
ForEach-Object { $_.'Date Printed' = "$printdate"; return $_ } | ` Sort-Object -Property @{Expression = "Parent Correspondence ID"; Ascending = $True}, @{Expression = "Correspondence ID"; Ascending = $True} | Export-CSV -Path "Y:\Order Preparation\Sutter Health\Current Job Indices\$todaysdate-index\$batchidname\$sutterindex" -NoTypeInformation -Force

#Make new folder to move items into with todays date, item type, and batchID

mkdir Y:\'Files to Digital Press'\'SUTTER HEALTH'\$todaysdate-letters\ -ErrorAction SilentlyContinue
mkdir Y:\'Files to Digital Press'\'SUTTER HEALTH'\$todaysdate-letters\$batchidname -ErrorAction SilentlyContinue
mkdir Y:\1-PREFLIGHT\SUTTER_ID_CARDS\$todaysdate-cards\ -ErrorAction SilentlyContinue
mkdir Y:\1-PREFLIGHT\SUTTER_ID_CARDS\$todaysdate-cards\$batchidname -ErrorAction SilentlyContinue

#Move items with id_card in the name unless they have letter in the name
Get-ChildItem -path X:\$batchname\$batchname\$batchidname\* -exclude *letter* -include *id_card* | move-item -destination Y:\1-PREFLIGHT\SUTTER_ID_CARDS\$todaysdate-cards\$batchidname

#Take and move index file
Get-ChildItem -path x:\$batchname\$batchname\$batchidname\* -include *CommerceIndex* | move-item -Destination I:\'Sutter Batch Processing'\'Original Index Dump' #Y:\'Order Preparation'\'Sutter Health'\'Current Job Indices'\$todaysdate-index\$batchidname

#Move all remaining items
Get-ChildItem -path X:\$batchname\$batchname\$batchidname\* | move-item -destination Y:\'Files to Digital Press'\'SUTTER HEALTH'\$todaysdate-letters\$batchidname


$lettersinbatch = (Get-ChildItem -path Y:\'Files to Digital Press'\'SUTTER HEALTH'\$todaysdate-letters\$batchidname | measure-object).count
write-output "Batch number $batchid has $lettersinbatch letters."
$cardsinbatch = (Get-childItem -path Y:\1-PREFLIGHT\SUTTER_ID_CARDS\$todaysdate-cards\$batchidname | `
 measure-object).count
write-output "Batch number $batchid has $cardsinbatch member ID cards."
$orderforminfo = "$batchidname `r`n letters: $lettersinbatch `r`n Member ID Cards: $cardsinbatch" | `
out-file -filepath "C:\sutter sorting\BatchCount$todaysdate.txt" -append


#Set due date 2 normal, 1 premium no due dates on weekends
if($batchname -like '*premium*'){
$duedays = 1;
}
else{
$duedays = 2;
}

$duedate = (get-date).adddays($duedays)
if($duedate.dayofweek -eq 'Saturday' -or $duedate.dayofweek -eq 'Sunday'){
$dd = $duedate.adddays(2).ToString('MM/dd');
$duedate = $duedate.adddays(2).ToString('MM-dd-yy');
}
else{
$dd = $duedate.ToString('MM/dd');
$duedate = $duedate.ToString('MM-dd-yy');
}

#Write datamerge.csv for importing to InDesign order form
import-csv 'C:\Sutter Sorting\datamerge.csv'
$datamerge = @(
[pscustomobject]@{
"Date" = $todaysdate
"Folder-Name" = $batchidname
"No-Letters" = $lettersinbatch
"No-Cards" = $cardsinbatch
"Due-date" = $duedate
"Notes" = $batchnotes
}
)
$datamerge | Export-csv -path "I:\Sutter Batch Processing\DailyBatchInfo\$todaysdate.csv" -Append -notypeinfo
$dailydatamerge = Import-Csv -path "I:\Sutter Batch Processing\DailyBatchInfo\$todaysdate.csv"
$dailydatamerge | Export-csv -path 'I:\Sutter Batch Processing\Sutter\datamerge.csv' -Force -NoTypeInformation
#This Section of the script generates a CSV file that is ready to be copied to the jobs list, 

$sutterjobslist = import-csv -path "Y:\Order Preparation\Sutter Health\Current Job Indices\$todaysdate-index\$batchidname\$sutterindex"
#$sutterjobslist | ForEach { $_.PSObject.Properties.Remove('Is Updatable'),$_.PSObject.Properties.Remove('Estimated Delivery Date'),$_.PSObject.Properties.Remove('Testing Comments'),$_.PSObject.Properties.Remove('Sweep Type') } 
$sutterjobslist | ForEach-Object { $_ | Add-Member -MemberType NoteProperty -Name BatchID -value $batchid }
$sutterjobslist | select-object -Property 'BatchID','Correspondence FileName', 'Correspondence DefinitionName', 'Correspondence ID', 'Parent Correspondence ID', 'Correspondence Entity Name', 'Correspondence Entity ID', 'Correspondence Sub Account id', 'Date Run', 'Date Transferred', 'Date Printed' | `
export-csv -path "I:\Sutter Batch Processing\Daily Indices\$todaysdate-sutterjoblist.csv" -Append -NoTypeInformation
#Add-Content -Path "I:\Sutter Batch Processing\Daily Indices\$todaysdate-sutterjoblist.csv"  -Value "'',$batchid,$batchid,$batchid,$batchid,$batchid,$batchid,$batchid,$batchid,$batchid,$batchid,'ENDOFBATCH'"
$bnum | export-csv -path 'I:\Sutter Batch Processing\bnum.csv' -NoTypeInformation
$batchesleft -= 1
$td = (get-date).ToString('MM/dd');
# $dd = $dd Referenced when determining due date
if($cardsinbatch -ge 1){
$status = "epp";
}
else{
$status = "Ok to print $td"
}
$dsc = $bnum.lastbatch;
$qty = $lettersinbatch;

$psched = @(
[pscustomobject]@{
"Sales" = 'KM'
"CSR" = 'LR'
"Rcvd" = $td
"Due" = $dd
"Customer" = 'Sutter Health Plus'
"Description" = "Batch $dsc"
"Status" = $status
"Qty" = $qty
"Comments" = ' '
"Production Comments" = "We will mail these out"
}
)
$psched | export-csv -Path "I:\Sutter Batch Processing\Sutter\$todaysdate`_commercelog.csv" -NoTypeInformation -Append
echo "KM, LR, $td, $dd, Sutter Health Plus, Batch $dsc, $status, $qty"
}

