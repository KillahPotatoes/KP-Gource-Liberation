function Get-CWD-History {
    return (git log --pretty=format:user:%aN:%ce%n%ct --reverse --raw --encoding=UTF-8 --no-renames) # user:NAME:EMAIL
}
function Get-Clean-History {
    param (
        [array]     $historyString,
        [object]    $peopleMap
    )

    foreach ($replObj in $peopleMap) {
        $name = $replObj.name
        foreach ($email in $replObj.mails) {
            $historyString = $historyString -replace "^user:(.*):($email)","user:$name"
        }
    }
    
    foreach ($replObj in $peopleMap) {
        $name = $replObj.name
        foreach ($alias in $replObj.aliases) {
            $historyString = $historyString -replace "^user:($alias):(.*)","user:$name"
        }
    }

    return $historyString
}

# Get GREUH Liberation history
Set-Location $PSScriptRoot/greuh_liberation
$greuhHistory = Get-CWD-History;
# Back to root dir
Set-Location $PSScriptRoot

$greuhPeople = Get-Content .\people_map\greuh.json | ConvertFrom-JSON

(Get-Clean-History -historyString $greuhHistory -peopleMap $greuhPeople) | Out-File -FilePath "log\greuh_log.txt" -Encoding ASCII -Force

# TODO
## Get KP Liberation history
# Set-Location $PSScriptRoot/kp_liberation
# $kpHistory = Get-CWD-History
## Back to root dir
# Set-Location $PSScriptRoot


# $kpHistory | Out-File -FilePath "kp_log.txt"