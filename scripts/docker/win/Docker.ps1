[CmdletBinding()]
param(
    [string] $arg_action,
    [string] $arg_env
)

$current_location = Get-Location

. "$current_location\scripts\docker\win\Commons.ps1"
. "$current_location\scripts\docker\win\Scripts-Functions.ps1"
. "$current_location\scripts\docker\win\Get-Application-Port.ps1"
. "$current_location\scripts\docker\win\Get-Action-Help-Message.ps1"
. "$current_location\scripts\docker\win\New-Docker-Image.ps1"
. "$current_location\scripts\docker\win\New-Docker-Container.ps1"


Run-Command-Action -arg_action $arg_action -arg_env $arg_env