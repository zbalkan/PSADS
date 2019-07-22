<#
.SYNOPSIS
Clears the contents of a specified ADS or all ADSs of a file
.DESCRIPTION
When the Stream name is defined the function clears the content if exists. When not defined, it clears all except the default.
.EXAMPLE
Clear-ADS -Path Foo.txt
.EXAMPLE
Clear-ADS -Path Foo.txt -Stream Bar
.INPUTS
Path and Stream
.OUTPUTS

.NOTES
NTFS Alternate Data Streams are removed using this function. This is just a syntactic sugar wrapping exising capabilities.
#>
function Clear-ADS {
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
                Clear-Content -Path $Path -Stream $Stream
            }
            else {
                Get-ADS -Path $Path | ForEach-Object { Clear-Content -Path $Path -Stream $_.Stream }
            }
        }
    }
    
    end {
    }
}