# docker build -t nestjs-services-<env>[:version] -f Dockerfile[.local]

$current_location = Get-Location

. "$current_location\scripts\docker\win\Commons.ps1"

function New-Docker-Image
{
    param(
        [string] $args_env
    )

    $envs = @{ development = ".local"; production = "" }
    $env = "production"
    $service_name = Get-Application-Name
    $service_version = Get-Application-Version
    $cmd_service_version = ""
    $cmd_local_dockerfile = "";

    if ($args_env -ne '' -AND $envs.ContainsKey($args_env)) {
        $env = $args_env
        $cmd_local_dockerfile = $envs[$env]
    }

    if ($service_version -ne '') {
        $cmd_service_version = ":$service_version"
    }

    $cmd = "docker build -t $service_name-$env$cmd_service_version -f Dockerfile$cmd_local_dockerfile ."

    Write-Verbose -Message "Run command: $cmd"
    Invoke-Expression $cmd
}
