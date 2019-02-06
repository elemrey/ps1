$filoop = 1
while ($filoop -ge 1){
$findindex = read-host "Name of index to be found"
$indexfolder = Get-ChildItem -path ("Y:\Order Preparation\Sutter Health\Current Job Indices") -Include "*$findindex" -recurse 
#| copy -Destination "I:\Sutter Batch Processing\rqin"
Write-Output "$indexfolder.directory"
$indexfolder.directory | Out-File "C:\Sutter Sorting\rqin.txt" -Append -Force
++$filoop
}