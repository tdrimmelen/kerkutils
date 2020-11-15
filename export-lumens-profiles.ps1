$basePath="C:\Users\Test\Dropbox\PGS Stream team\Configuratie\camera presets\"

function Export-Config {
    param (
        [string] $Camera,
        [string] $Path

    )
    
    curl.exe "http://${Camera}/presetfilesave.cgi" `
    -X "POST" `
    -H "Connection: keep-alive" `
    -H "Content-Length: 0" `
    -H "Authorization: Basic YWRtaW46OTk5OQ==" `
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36" `
    -H "Accept: */*" `
    -H "Accept-Language: nl-NL,nl;q=0.9,en-US;q=0.8,en;q=0.7" `
    -H "Cookie: userName=admin; passWord=9999; authority=0" `
    --insecure `
    --output ${Path}

}

$date=Get-Date -Format "yyyy-MM-dd HH-mm-ss"

New-Item -Path $basePath -Name $date -ItemType "directory"

Export-Config -Camera 10.12.0.11 -Path ($basePath + $date + "/camera1.bin")