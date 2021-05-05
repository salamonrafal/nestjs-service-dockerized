$current_location = Get-Location

. "$current_location\scripts\docker\win\Commons.ps1"

function New-Docker-Container
{
    param(
        [string] $args_env
    )

    $ports = Get-Application-Ports
}