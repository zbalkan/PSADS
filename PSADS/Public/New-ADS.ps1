<#
.SYNOPSIS
Adds a new ADS to a defined file with the value.
.DESCRIPTION
All parameters are mandatory.
.EXAMPLE
New-ADS -Path Foo.txt -Stream Bar -Value $Baz
.INPUTS
Path, Stream and Value
.OUTPUTS

.NOTES
NTFS Alternate Data Streams are removed using this function. This is just a syntactic sugar wrapping exising capabilities.
#>
function New-ADS {
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
    [Parameter(Mandatory=$true,
    Position=1,
    ValueFromPipeline=$false,
    ValueFromPipelineByPropertyName=$false,
    ValueFromRemainingArguments=$false)]
    [string]
    $Stream,

    # Value
    [Parameter(Mandatory=$true,
    Position=2,
    ValueFromPipeline=$false,
    ValueFromPipelineByPropertyName=$false,
    ValueFromRemainingArguments=$false)]
    $Value
    )
    
    begin {
    }
    
    process {
        if ($pscmdlet.ShouldProcess("Target", "Operation")) {
            Add-Content -Path $Path -Stream $Stream -Value $Value
        }
    }
    
    end {
    }
}