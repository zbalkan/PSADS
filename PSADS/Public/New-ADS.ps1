function Get-ADS (){
    [CmdletBinding()]
    param (
    [string]
    $Path,

    [string]
    $Stream,

    $Value
    )
    process {
        Add-Content -Path $Path -Stream $Stream -Value $Value
    }
}