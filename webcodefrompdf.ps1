 #$links = read-host "Filepath for csv with materials list"
 $links= "I:\Sutter Julianna\downloadmaterials.csv"
 $materials = import-csv $links -header ("pdfname","friendlyname")
 #$materials = import-csv I:\Storefront\soemats.csv -header ("pdfname","friendlyname")
 ForEach ($pdfname in $materials)
 {
 $thispdf = $pdfname.pdfname
 $friendlyname = $pdfname.friendlyname
 $tagpdf = $thispdf.ToLower()
 $webform = "<div class=`"rowcontainer`"><div class=`"picturebox`"><a href=`"/clients/wp-content/uploads/$thispdf.pdf`"><h5>$friendlyname</h5></a><a href=`"/clients/wp-content/uploads/$thispdf.jpg`" class=`"prettyphoto`"><img class=`"alignnone size-medium wp-image-28`" src=`"/clients/wp-content/uploads/$thispdf.jpg`" alt=`"$thispdf`"></a></div>`n<div class=`"mailtag`">$thispdf<br>$friendlyname <a href=`"/clients/wp-content/uploads/$thispdf.pdf`">pdf file</a><br><h6>Enter Quantity:</h6>[text $tagpdf]</div>`n</div> `n `n" | out-file -filepath "I:\Sutter Julianna\webform.txt" -force -Append
 
 $mailform = "<tr><td><strong>[$tagpdf]</strong></td><td><a href=`"http://clients.commerceprinting.com/clients/wp-content/uploads/$thispdf.pdf`">$thispdf`_$friendlyname</a></td></tr>" | out-file -filepath "I:\Sutter Julianna\webmail.txt" -force -Append
 
 }
