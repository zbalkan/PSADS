# PSADS
PSADS is a module to manage NTFS Alternate Data Streams through PowerShell functions.

It does not attempt to give you advanced options which you cannot get by making use of existing PowerShell cmdlets. It just wraps them in order to manage the streams in a simpler way and constitutes nothing more than a syntactic sugar.

## Functions
### Get-ADS
Gets the Alternate Data Streams of a file: `Get-ADS -Path Foo.txt`

You can also check if a specific stream exists: `Get-ADS -Path Foo.txt -Stream Bar`

### Export-ADS
Exports the Alternate Data Streams of a file: `Export-ADS -Path Foo.txt`

You can also export a specific stream: `Export-ADS -Path Foo.txt -Stream Bar`

#### Note
This command does not remove the ADS. It only creates a symlink for each of the streams so that it does not intend to modify the file itself. It is possible to get the data of a stream and creating a new file.

### New-ADS
Adds a new Alternate Data Stream to a file with the specified name including the value: `New-ADS -Path Foo.txt -Stream Bar -Value $Value`

### Set-ADS
Modifies the Alternate Data Stream of a file with the specified name including the value: `Set-ADS -Path Foo.txt -Stream Bar -Value $Value`

### Remove-ADS
Removes all of the Alternate Data Streams of a file: `Remove-ADS -Path Foo.txt`

When specified it is possible to remove the ADS only: `Remove-ADS -Path Foo.txt -Stream Bar`

#### Note
You can use this command to unblock downloaded files. `Remove-ADS -Path Foo.txt -Stream Zone.Identifier`

### Clear-ADS
Clear the context of all of the Alternate Data Streams of a file: `Clear-ADS -Path Foo.txt`

When specified it is possible to clean the context of the ADS only: `Clear-ADS -Path Foo.txt -Stream Bar`

## Installation
1. Run the `$Env:PSModulePath`command. Decide which of the module path you need to use according to your requirements. Avoid using `$PSHome\Modules (%Windir%\System32\WindowsPowerShell\v1.0\Modules)` as your path since it belongs to modules shipped with Windows.
2. [Download](https://github.com/zbalkan/PSADS/archive/master.zip) the module to the path you decided on the previous step.
3. Open a new PowerShell window and type `Get-Module -ListAvaliable` to check if the module is listed.
