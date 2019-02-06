$lastweek = ((get-date).AddDays(-7))
get-item -Path "X:\*" -Exclude "Updated Indices","IRS 1095","*public*" | Where-Object {$_.LastAccessTime -le $lastweek} | move-item -Destination "\\CPSSDNAS01\cpsnasv3\Production Print Archive\2018" -WhatIf


