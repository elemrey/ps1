#This bit of code imports a CSV that already has the appropriate headers and feeds it rows of data (an object with various properties)
#This one is feeding the batch data into a CSV that I will use to merge data onto the sutter order forms 

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
$datamerge | Export-csv -path C:\'Sutter Sorting'\BatchCount$todaysdate.csv -Append -notypeinfo

