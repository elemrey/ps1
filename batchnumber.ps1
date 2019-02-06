$bnum = Import-Csv -path 'C:\Sutter Sorting\var\bnum.csv'
[int]$bnum.lastbatch +=1
$bnum | export-csv -path 'C:\Sutter Sorting\var\bnum.csv' -NoTypeInformation
$batchid = $bnum.lastbatch
Write-Output "Current batch numbers is $batchid"


