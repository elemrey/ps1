$csvcolumns = import-csv -path "C:\Sutter Sorting\CommerceIndex_LtrIDCards_20181016210248.csv"
#$csvcolumns | ForEach {$_.PSObject.Properties.Remove('Is Updatable'),$_.PSObject.Properties.Remove('Estimated Delivery Date'),$_.PSObject.Properties.Remove('Testing Comments'),$_.PSObject.Properties.Remove('Sweep Type') } 
$csvcolumns | ForEach-Object { $_ | Add-Member -MemberType NoteProperty -Name BatchID -Value $batchid } | export-csv -path 'C:\Sutter Sorting\testindexout.csv'
$csvcolumns = import-csv -Path "C:\Sutter Sorting\testindexout.csv"
$csvcolumns | Select-Object -property 'BatchID','Correspondence FileName', 'Correspondence DefinitionName', 'Correspondence ID', 'Parent Correspondence ID', 'Correspondence Entity Name', 'Correspondence Entity ID', 'Correspondence Sub Account id', 'Date Run', 'Date Transferred', 'Date Printed' | export-csv -path "c:\sutter sorting\testindexout3.csv" -Force -NoTypeInformation -Append
#$csvcolumns | export-csv -path "c:\sutter sorting\testindexout3.csv" -Force
 export-csv -path "C:\Sutter Sorting\testindexout2.csv"  -NoTypeInformation -Force
Add-Content -Path "C:\Sutter Sorting\testindexout.csv"  -Value ",$batchid,$batchid,$batchid,$batchid,$batchid,$batchid,$batchid,$batchid,$batchid,$batchid,'ENDOFBATCH'" 
