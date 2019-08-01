<#
.SYNOPSIS
Exports a specified ADS or all ADSs of a file as a symbolic link.
.DESCRIPTION
When the Stream name is defined the function outputs one symlink for each, if exists. When not defined, it outputs all except the default.
.EXAMPLE
Export-ADS -Path Foo.txt
.EXAMPLE
Export-ADS -Path Foo.txt -Stream Bar
.INPUTS
Path and Stream
.OUTPUTS
One Symlink for each of the Streams (if any)
.NOTES
NTFS Alternate Data Streams are removed using this function. This is just a syntactic sugar wrapping exising capabilities.
#>
function Export-ADS {
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
                Get-ADS -Path $Path -Stream $Stream |
                ForEach-Object {
                    $item = Get-Item $Path
                    [void] (New-Item -Path (Join-Path -Path $item.Directory -ChildPath "$($item.Name)_$($_.Stream)") -ItemType SymbolicLink -Value ("$($item.FullName):$($_.Stream)") -Force -Confirm:$false)
                }
            }
            else {
                Get-ADS -Path $Path |
                ForEach-Object {
                    $item = Get-Item $Path
                    [void] (New-Item -Path (Join-Path -Path $item.Directory -ChildPath "$($item.Name)_$($_.Stream)") -ItemType SymbolicLink -Value ("$($item.FullName):$($_.Stream)") -Force -Confirm:$false)
                }
            }
        }
    }

    end {
    }
}