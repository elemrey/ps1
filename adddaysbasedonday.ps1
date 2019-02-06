if((get-date).dayofweek -eq 'Monday'){
$duedate = (((Get-Date).adddays(4)).ToString('MM-dd-yy'))
}
else
{
$duedate = (((Get-Date).adddays(6)).ToString('MM-dd-yy'))
}
Write-Output $duedate
