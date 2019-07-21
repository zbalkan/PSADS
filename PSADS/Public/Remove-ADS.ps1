function Remove-ADS (){
    [CmdletBinding()]
    param (
    [string]
    $Path
    )
    process {
        Get-ADS | ForEach-Object { Remove-Item -Path $Path -Stream $_.Stream }
    }
}