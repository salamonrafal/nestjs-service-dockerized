# docker container create

$current_location = Get-Location

. "$current_location\scripts\docker\win\Commons.ps1"

function New-Docker-Container
{
    param(
        [string] $arg_env
    )

    $ports = Get-Application-Ports
    $image_name = Set-Image-Name -arg_env $arg_env
}