#function get-duedate {
#param(
if($batchname -like '*premium*'){
$duedays = 1;
}
else{
$duedays = 2;
}

$duedate = (get-date).adddays($duedays)
if($duedate.dayofweek -eq 'Saturday' -or $duedate.dayofweek -eq 'Sunday'){
$duedate = $duedate.adddays(2).ToString('MM-dd-yy');
}
else{
$duedate = $duedate.ToString('MM-dd-yy');
}


#if((get-date).dayofweek -eq 'Thursday' -or (get-date).DayOfWeek -eq 'Friday'){
#$duedate = (((Get-date).adddays(4)).ToString('MM-dd-yy'))}
#else{}

#if($batchname -like '*premium*' -and (get-date).dayofweek -eq 'Thursday')
#{ $duedate.adddays(-3)}
#elseif($batchname -like '*premium*')
#{ $adddue -= 1}
#else{}
#$duedate = (((Get-date).adddays($adddue)).ToString('MM-dd-yy'))

