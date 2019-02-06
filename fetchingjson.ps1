$bnum = Get-content 'C:\Sutter Sorting\var\batchnum.json' -raw | convertfrom-json
$bnum.BatchNum | 
$batchid = $bnum.BatchNum.lastbatch

