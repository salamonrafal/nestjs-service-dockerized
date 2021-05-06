$current_location = Get-Location

. "$current_location\scripts\docker\win\Commons.ps1"

function Get-Application-Port
{
    Write-Verbose -Message "Show docker container ports"

    $ports = Get-Application-Ports

    Write-Host ($ports["host"], $ports["container"]) -Separator ":" -ForegroundColor DarkGreen
}