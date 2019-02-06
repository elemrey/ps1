$lastdateupdate = (Get-Itemproperty -path 'I:\Sutter Batch Processing\Index to be uploaded' lastwritetime | select lastwritetime)
$lastdateupdate = ($lastdateupdate |get-date -UFormat "%m/%d/%Y")
#$shippedfix = ($shippedon | Get-Date -UFormat "%m/%d/%Y")
$batchtoupdate = (Get-ChildItem -Path 'Y:\Files to Digital Press\SHP Billing\*_*.pdf' | where-object -property lastwritetime -gt $lastdateupdate |select-object {$_.Name.Substring(0,4)} )