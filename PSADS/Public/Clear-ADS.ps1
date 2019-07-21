function Remove-ADS (){
    [CmdletBinding()]
    param (
    [string]
    $Path
    )
    process {
        Get-ADS -Path $Path | ForEach-Object { Clear-Content -Path $Path -Stream $_.Stream }
    }
}



