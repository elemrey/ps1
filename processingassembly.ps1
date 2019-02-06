# In this script I would like to load the data from the Assembly Reprop Order Log, 
# and then create a new spreadsheet that only has the columns I want once that is sorted out

import-csv -path "C:\Sutter Sorting\CPS Assembly Reprographics Order Log\CPS Assembly Reprographics Order Log New.xlsx" | `
ForEach-Object {