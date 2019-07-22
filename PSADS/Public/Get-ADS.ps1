<#
.SYNOPSIS
Enumerates a specified ADS or all ADSs of a file
.DESCRIPTION
When the Stream name is defined the function outputs if exists. When not defined, it outputs all except the default.
.EXAMPLE
Get-ADS -Path Foo.txt
.EXAMPLE
Get-ADS -Path Foo.txt -Stream Bar
.INPUTS
Path and Stream
.OUTPUTS
Stream or Streams (if any)
.NOTES
NTFS Alternate Data Streams are removed using this function. This is just a syntactic sugar wrapping exising capabilities.
#>
function Get-ADS {
    [CmdletBinding(SupportsShouldProcess=$true,
    PositionalBinding=$false,
    HelpUri = 'http://www.github.com/zbalkan/PSADS',
    ConfirmImpact='Medium')]
    [Alias()]
    Param (
    # Path of the file
    [Parameter(Mandatory=$true,
    Position=0,
    ValueFromPipeline=$true,
    ValueFromPipelineByPropertyName=$true,
    ValueFromRemainingArguments=$false)]
    [ValidateNotNull()]
    [ValidateNotNullOrEmpty()]
    [string]
    $Path,
    
    # Stream
    [Parameter(Mandatory=$false,
    Position=1,
    ValueFromPipeline=$false,
    ValueFromPipelineByPropertyName=$false,
    ValueFromRemainingArguments=$false)]
    [string]
    $Stream
    )
    
    begin {
    }
    
    process {
        if ($pscmdlet.ShouldProcess("Target", "Operation")) {
            if($null -eq $Stream -and $Stream.Length -ne 0) {
                Get-Item $Path -Stream $Stream | Select-Object -Property Stream
            }
            else {
                Get-Item $Path -Stream * | Select-Object -Property Stream -Skip 1
            }
        }
    }
    
    end {
    }
}