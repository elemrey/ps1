$adddue = 2
if((get-date).dayofweek -eq 'Thursday','Friday')
{ $adddue += 2}
else{}

if($batchname -like '*premium*' -and (get-date).dayofweek -eq 'Thursday')
{ $adddue -= 3}
elseif($batchname -like '*premium*')
{ $adddue -= 1}
else{}
$duedate = (((Get-date).adddays($adddue)).ToString('MM-dd-yy'))

#Set variable due in order to name folders by current date
if((get-date).dayofweek -eq 'Thursday','Friday'){
$duedate = (((Get-Date).adddays(4)).ToString('MM-dd-yy'))
}
else{
$duedate = (((Get-Date).adddays(2)).ToString('MM-dd-yy'))
}
if($batchname -like '*premium*')
{$duedate = ((($duedate).adddays(-1)).ToString('MM-dd-yy'))
}
else{}
