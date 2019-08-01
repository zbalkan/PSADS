<#
.SYNOPSIS
Exports a specified ADS or all ADSs of a file as a symbolic link (default) or file.
.DESCRIPTION
When the Stream name is defined the function outputs one symlink or file for each, if exists. When not defined, it outputs all except the default.
When file is exported the file extension is set to ".UNKNOWN"
.EXAMPLE
Export-ADS -Path Foo.txt
.EXAMPLE
Export-ADS -Path Foo.txt -Stream Bar
.EXAMPLE
Export-ADS -Path Foo.txt -Stream Bar -Output File
.INPUTS
Path and Stream
.OUTPUTS
One Symlink or File for each of the Streams (if any)
.NOTES
NTFS Alternate Data Streams are exported using this function. This is just a syntactic sugar wrapping exising capabilities.
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
        $Stream,

        # Output Type (Symlink by Default)
        [Parameter(Mandatory=$false,
            Position=2,
            ValueFromPipeline=$false,
            ValueFromPipelineByPropertyName=$false,
            ValueFromRemainingArguments=$false)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet("Symlink", "File")]
        [string]
        $Output
        )
    
    begin {
    }
    
    process {
        if ($pscmdlet.ShouldProcess("File in the path", "Export the ADS")) {
            if($null -eq $Stream -and $Stream.Length -ne 0) {
                $Streams = Get-ADS -Path $Path -Stream $Stream
            }
            else {
                $Streams = Get-ADS -Path $Path
            }

            $Streams | ForEach-Object {
                $item = Get-Item $Path
                if($Output -eq "Binary") {
                    [void] (New-Item -Path (Join-Path -Path $item.Directory -ChildPath "$($item.Name)_$($_.Stream).UNKNOWN") -ItemType File -Value (Get-Content "$($item.FullName):$($_.Stream)" -Raw) -Force -Confirm:$false)
                }
                else {
                    [void] (New-Item -Path (Join-Path -Path $item.Directory -ChildPath "$($item.Name)_$($_.Stream)") -ItemType SymbolicLink -Value  ("$($item.FullName):$($_.Stream)") -Force -Confirm:$false)
                }
            }
        }
    }
    
    end {
    }
}