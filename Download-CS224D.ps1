# download the HTML page first
$coursePage = Invoke-WebRequest -Uri "https://cs224d.stanford.edu/syllabus.html"

# extract all interesting links to download
$courseMaterial = $coursePage.Links | Where-Object {$_.href -like "*.pdf"} 

# iterate through all links and download
foreach ($doc in $courseMaterial)
{
    # build file name for download
    $urlParts = $doc.href.split('/')
    $fileName = "<your local path>" + $urlParts[$urlParts.Length - 1];
    if ($doc.href.StartsWith("http"))
    {
        $url = $doc.href
    }
    else 
    {
        $url = "https://cs224d.stanford.edu/" + $doc.href
    }

    # download the file and save it
    Invoke-WebRequest -Uri $url -OutFile $fileName
}