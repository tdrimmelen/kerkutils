[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

$basePath="C:\Users\pgska\Dropbox\PGS Stream team\Configuratie\camera presets\golden preset normale dienst"

function Import-Config {
    param (
        [string] $Camera,
        [string] $Path

    )
    
    $upload = curl.exe "http://${Camera}/presetfileload.cgi" `
    -X "POST" `
    -H "Connection: keep-alive" `
    -H "Authorization: Basic YWRtaW46OTk5OQ==" `
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36" `
    -H "Accept: */*" `
    -H "Accept-Language: nl-NL,nl;q=0.9,en-US;q=0.8,en;q=0.7" `
    -H "Cookie: userName=admin; passWord=9999; authority=0" `
    --insecure `
    -F filename="@$Path"


    $uploadresult = curl.exe "http://${Camera}/vb.htm?getpresetuploadstatus" `
    -H "Accept: */*" `
    -H "Accept-Language: nl-NL,nl;q=0.9,en-US;q=0.8,en;q=0.7" `
    -H "Authorization: Basic YWRtaW46OTk5OQ==" `
    -H "Connection: keep-alive" `
    -H "Cookie: userName=admin; passWord=9999; authority=0" `
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36" `
    -H "X-Requested-With: XMLHttpRequest" `
    --insecure

    $resultAsInt = $uploadresult -as [int]

    return $resultAsInt

}

#Ask confirmation before starting
$return = [System.Windows.Forms.MessageBox]::Show("Wil je de golden presets voor de cameras laden?","Herstellen naar golden preset",[System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)
if ($return -ne 'Yes')
{
    exit
}

#Camera 1
$result = Import-Config -Camera 10.12.0.11 -Path "${basePath}\camera1.bin"
if ($result -ne 1)
{
    $return = [System.Windows.Forms.MessageBox]::Show("Kan preset voor camera 1 niet laden (fout=${result})","Fout",[System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
} 

#Camera 2
$result = Import-Config -Camera 10.12.0.12 -Path "${basePath}\camera2.bin"
if ($result -ne 1)
{
    $return = [System.Windows.Forms.MessageBox]::Show("Kan preset voor camera 2 niet laden (fout=${result})","Fout",[System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
} 

#Camera 3
$result = Import-Config -Camera 10.12.0.13 -Path "${basePath}\camera3.bin"
if ($result -ne 1)
{
    $return = [System.Windows.Forms.MessageBox]::Show("Kan preset voor camera 3 niet laden (fout=${result})","Fout",[System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
} 
