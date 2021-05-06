# docker build -t nestjs-services-<env>[:version] -f Dockerfile[.local]
$current_location = Get-Location

. "$current_location\scripts\docker\win\Commons.ps1"

function New-Docker-Image
{
    param(
        [string] $arg_env
    )

    $envs = @{ development = ".local"; production = "" }
    $env = "production"
    $image_name = Set-Image-Name -arg_env $arg_env
    $cmd_local_dockerfile = "";

    if ($arg_env -ne '' -AND $envs.ContainsKey($arg_env)) {
        $env = $arg_env
        $cmd_local_dockerfile = $envs[$env]
    }

    $cmd = "docker build -t $image_name -f Dockerfile$cmd_local_dockerfile ."

    Write-Verbose -Message "Run command: $cmd"
    Invoke-Expression $cmd
}
