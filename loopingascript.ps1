$batchesleft = read-host "How many batches are you running"
while ($batchesleft -gt 0)
{    
    $talktome = read-host "type anything here"
    Write-Output $talktome
    $batchesleft -= 1
    Write-Output $batchesleft

}


