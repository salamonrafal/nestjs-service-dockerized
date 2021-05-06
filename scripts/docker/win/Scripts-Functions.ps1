$current_location = Get-Location

function Get-Script-Config-JSON
{
    return Get-Content -Path "$current_location\scripts\docker\win\config.json" -Raw | ConvertFrom-Json
}

function Get-Action-List
{
    $json = Get-Script-Config-JSON

    return $json.actions
}

function Get-Default-Action
{
    $json = Get-Script-Config-JSON

    return $json.defaultAction
}

function Get-Action-Config
{
    param(
        [string] $arg_action
    )

    $actions = Get-Action-List

    foreach ($obj in $actions.PSObject.Properties)
    {
        if ($obj.Name -eq $arg_action) {
            return $obj.Value
        }
    }

    return $FALSE
}

function Join-Command-Action-Parameter
{
    param (
        [string] $arg_cmd_template,
        [string[]] $arg_params_name,
        [string[]] $arg_param_value
    )

    $cmd = $arg_cmd_template

    for ($i= 0; $i -lt $arg_params_name.length; $i++) {
        $name = "{" + $arg_params_name[$i] + "}"
        $value = $arg_param_value[$i]

        $cmd = $cmd -replace $name,$value
    }

    return $cmd
}

function Run-Command-Action
{
    param (
        [string] $arg_action,
        [string] $arg_env
    )

    $action = Get-Action-Config -arg_action $arg_action

    if ($action -eq $FALSE) {
        $defaultAction = Get-Default-Action
        $action = Get-Action-Config -arg_action $defaultAction
        $command = Join-Command-Action-Parameter -arg_cmd_template $action.script
    } else {
        $command = Join-Command-Action-Parameter -arg_cmd_template $action.script -arg_params_name $action.args -arg_param_value $arg_env
    }

    Write-Verbose -Message "Run command: $command"
    Invoke-Expression $command
}
