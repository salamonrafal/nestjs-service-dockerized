function Get-Package-JSON
{
    return Get-Content -Path "$current_location\package.json" -Raw | ConvertFrom-Json
}

function Get-Application-Ports
{
    $json = Get-Package-JSON
    $ports = @{host = $json.docker.ports[0]; container = $json.docker.ports[1]}

    return $ports
}

function Get-Application-Version
{
    $json = Get-Package-JSON

    return $json.version
}

function Get-Application-Name
{
    $json = Get-Package-JSON

    return $json.name
}
