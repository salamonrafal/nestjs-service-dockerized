[CmdletBinding()]
param(
    [string] $args_action,
    [string] $args_env
)

$current_location = Get-Location

. "$current_location\scripts\docker\win\New-Docker-Image.ps1"
. "$current_location\scripts\docker\win\New-Docker-Container.ps1"
. "$current_location\scripts\docker\win\Commons.ps1"


$actions = @{
    help = "help";
    build = "build";
    create_container = "create_container"
    ports = "ports";
}

if ($args_action -ne '' -AND $actions.ContainsKey($args_action)) {
    $action = $actions[$args_action]
}
else
{
    $action = "help"
}

switch ($action) {
    $actions["help"] {
        "Display help command"
    }

    $actions["build"] {
        Write-Verbose -Message "Build new docker image"

        New-Docker-Image -args_env $args_env
    }

    $actions["create_container"] {
        Write-Verbose -Message "Create new docker container"

        New-Docker-Container -args_env $args_env
    }

    $actions["ports"] {
        Write-Verbose -Message "Show docker container ports"

        $ports = Get-Application-Ports

        Write-Host ($ports["host"], $ports["container"]) -Separator ":" -ForegroundColor DarkGreen
    }
}



