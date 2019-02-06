
# This creates a CSV file with headers
Add-Content -Path C:\"sutter sorting"\datamergetest.csv  -Value '"Date","Folder-Name","No-Letters","No-Cards","Due-Date"'

  $orderinfo = @(

  "$todaysdate,$batchidname,$lettersinbatch,$cardsinbatch,$duedate"

  )

  $orderinfo | foreach { Add-Content -Path  C:\"sutter sorting"\datamergetest.csv -Value $_ }