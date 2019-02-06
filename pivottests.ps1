#$pivotindex = import-csv -path "C:\Sutter Sorting\CommerceIndex_LtrIDCards_20181016210248.csv"
$pivotindex | convertfrom-csv | export-excel -path 'C:\Sutter Sorting\pivottable.xlsx'  | Add-PivotTable -ExcelPackage $pivotindex -PivotTableName SutterIndex -SourceRange $pivotindex
$excel = Get-Service | Export-Excel -Path test.xlsx -WorksheetName Services -PassThru -AutoSize -DisplayPropertySet -TableName ServiceTable -Title "Services on $Env:COMPUTERNAME"
Add-PivotTable -ExcelPackage $excel  -PivotTableName ServiceSummary   -SourceRange $excel.Workbook.Worksheets[1].Tables[0].Address -PivotRows Status -PivotData Name -NoTotalsInPivot -Activate
Close-ExcelPackage $excel -Show


import-csv 'C:\Sutter Sorting\CommerceIndex_LtrIDCards_20181016210248.csv' | Export-Excel 'C:\Sutter Sorting\pivottable.xlsx' `
-show `
-IncludePivotTable `
-IncludePivotChart `
-PivotRows 'Correspondence DefinitionName' `
-PivotData @{'Correspondence DefinitionName'='count'}
