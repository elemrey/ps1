$pdfname = Read-Host -Prompt "COPY PASTE or Enter the file name for the material to be uploaded"
$pdffile = "$pdfname.pdf"
$pdfphoto = "$pdfname.jpg"
$pdflink = "http://clients.commerceprinting.com/clients/wp-content/uploads/$pdffile"
$photolink = "http://clients.commerceprinting.com/clients/wp-content/uploads/$pdfphoto"
$friendlyname = read-host -Prompt "Enter the friendly name for this file"
$mailtag = $pdfname.ToLower()
$rowclass = "<div class=`"container neatbox`">"
$npbclass = "<div class=`"neatpicturebox`">"
$closediv = "</div>"
$mtagclass = "<div class=`"tagbox`">"

$iclass = "<a href=`"/clients/wp-content/uploads/$pdfphoto`" class=`"prettyphoto`"> <img class=`"alignnone size-medium wp-image-28`" src=`"/clients/wp-content/uploads/$pdfphoto`" alt=`"$pdfname`"></a><br></div>" 
$pdftag = "$pdfname <br> $friendlyname <a href=`"/clients/wp-content/uploads/$pdffile`">pdf file</a><br>"
$qtag = "<h6>Enter Quantity:</h6>[text $mailtag]</div>"


Write-Output "The following code contains the picture: `n $npbclass $iclass `n `
The following code contains the corresponding tag code: `n $mtagclass $pdftag $qtag"

$picturecode = "$npbclass $iclass"
$mtagcode = "$mtagclass $pdftag $qtag"
$outputform = "Picture code: $picturecode `n Mail Tag Code: $mtagcode `n Mail Form Code: `n <tr><td<<strong>[$mailtag]</strong></td><td><a href=`"$pdflink`">$pdfname`_$friendlyname</a></td></tr>" |
out-file -FilePath "\\cpsstor\Users\mikef\desktop\Sutter_Store_Front_PDFs\$pdfname`_webform.txt" -Append

#write-output "$dclass $d2class $iclass $pdftag $qtag $closediv $closediv `n `n"
#$webform = "$Pdfname`_$Friendlyname `n Form code: `n $dclass $d2class $iclass $pdftag $qtag $closediv $closediv `n ` 
#Mail code: `n <tr><td<<strong>[$mailtag]</strong></td><td><a href=`"$pdflink`">$pdfname`_$friendlyname</a></td></tr> `n" | `
 #out-file -filepath "\\cpsstor\Users\mikef\desktop\Sutter_Store_Front_PDFs\$pdfname`_webform.txt" -append

#$sutterform = "$dclass $d2class $iclass $pdftag $qtag $closediv $closediv"
#$suttermail = "<tr><td<<strong>[$mailtag]</strong></td><td><a href=`"$pdflink`">$pdfname`_$friendlyname</a></td></tr>"

#Add-Content -Path "I:\Storefront\sutterstorefront.csv"  -Value "$pdfname,$friendlyname,$sutterform,$suttermail"
