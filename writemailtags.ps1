$pdflink = Read-Host -prompt "Input PDF File Name"
$pdftitle = Read-host -prompt "Input human readable title"
$mailtag = Read-host -prompt "Input mail-tag"

write-output "<tr><td><<strong>[text $mailtag]>></td><td><a href='http://clients.commerceprinting.com/clients/wp-content/uploads/$pdflink'>"$pdftitle</a><td></tr>
