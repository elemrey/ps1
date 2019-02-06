$jobnumber = read-host "Enter Job Number?"
$ponumber = read-host "Enter PO Number"
$routenumber = read-host "Enter route number?"
$datenumber = read-host "Enter Date"
$sizenumber = read-host "Enter Size"
[int]$boxesnumber = read-host "Total box #"
[int]$perboxnumber = read-host "Number of units per box?"
$unitrate = $pricenumber/1000
$totalunits = $perboxnumber * $boxesnumber
$boxloops = $boxesnumber


while ($boxloops -ge "1") {
$vtasheet = @()
    $vtasheet += [PSCustomObject]@{
    "job number" = $jobnumber
    "po number" = $ponumber
    "route number" = $routenumber
    "effective date" = $datenumber
    "size" = $sizenumber
    "box of" = "$boxloops of $boxesnumber"
    "units per box" = "$perboxnumber"
    "total units ordered" = "$totalunits"
    "paper band in 25s" = ""
    }  
    $boxloops = $boxloops - 1
$vtasheet | export-csv 'C:\Sutter Sorting\vta.csv' -force -append
}
