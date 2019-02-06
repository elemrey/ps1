$lettersinbatch = (Get-ChildItem -path Y:\'Files to Digital Press'\'SUTTER HEALTH'\$todaysdate-letters\$batchidname | measure-object).count
write-output "Batch number $batchid has $lettersinbatch letters."

$cardsinbatch = (Get-childItem -path Y:\1-PREFLIGHT\SUTTER_ID_CARDS\$todaysdate-cards\$batchidname | `
 measure-object).count

write-output "Batch number $batchid has $cardsinbatch member ID cards."
$orderforminfo = "$batchidname `r`n letters: $lettersinbatch `r`n Member ID Cards: $cardsinbatch" | `
out-file -filepath "C:\sutter sorting\BatchCount$todaysdate.txt" -append
