$remainingindex = read-host "How many batches are we processing?"
while ($remainingindex -gt 0)
{
#Take user input for the batch #
$thisindex = read-host -prompt "Enter the batch# of the index you are looking for"
$shippedon = read-host -prompt "Enter the date this batch was shipped 'mm/dd/yyyy'"
#I'm using this line in case the wrong format was entered in the line above to convert it to mm/dd/yyyy in case it was entered as mm/dd/yy
$shippedfix = ($shippedon | Get-Date -UFormat "%m/%d/%Y")


#Find matching batch in Current Indices
$indexfolder = Get-ChildItem -path ("Y:\Order Preparation\Sutter Health\Current Job Indices") -Include "$thisindex`_*" -recurse
$thiscsv = (Get-ChildItem -path("$indexfolder")).FullName
$uploadindex = import-csv -path ("$thiscsv")
$updatedindexname =(get-itemproperty -path "$thiscsv").name

$todaysdate = ((Get-Date).ToString('MM-dd-yy'))
mkdir "I:\Sutter Batch Processing\Index to be uploaded\$todaysdate\" -ErrorAction SilentlyContinue

#Add upload date to the index and export it to folder for upload
$uploadindex | foreach-object {$_."Date Sent" ="$shippedfix"; return $_ } |`
convertto-csv -NoTypeInformation |`
% { $_ -replace '"', ""} |`
out-file "I:\Sutter Batch Processing\index to be uploaded\$todaysdate\$updatedindexname" -fo -en ascii
# export-csv -path "I:\Sutter Batch Processing\index to be uploaded\$todaysdate\$updatedindexname" -NoTypeInformation

$indexupdatedtoday = "Batch Number: $thisindex , $updatedindexname, shipped on: $shippedon" | `
out-file "I:\Sutter Batch Processing\index to be uploaded\$todaysdate\Indexfile.txt" -Append
$remainingindex -= 1
}
start "I:\Sutter Batch Processing\Index to be uploaded\$todaysdate\"
