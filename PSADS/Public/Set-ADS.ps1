function Set-ADS (){
    [CmdletBinding()]
    param (
    [string]
    $Path,
    [string]
    $Stream,
    
    $Value
    )
    process {
        Set-Content -Path $Path -Stream $Stream -Value $Value 
    }
}