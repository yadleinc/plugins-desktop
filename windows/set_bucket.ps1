# this plugin prompts the user to select a folder and writes it to bucket.txt for other plugins to use

Function Get-FolderPath{
[CmdletBinding()]
Param(
    [String]$Description,
    [String]$InitialDirectory = "C:\",
    [Switch]$NewFolderButton = $false)

    [void][System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")
    $FolderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $FolderBrowserDialog.SelectedPath = $InitialDirectory
    $FolderBrowserDialog.Description = $Description
    $FolderBrowserDialog.ShowNewFolderButton = $NewFolderButton
    If($FolderBrowserDialog.ShowDialog() -eq "OK"){
        $FolderBrowserDialog.SelectedPath
    }
}

$newPath = Get-FolderPath -Description "Select a folder" -InitialDirectory "C:\Desktop" -NewFolderButton
$bucketLocation = "$HOME\yadle\plugins\bucket.txt"

# $wshell = New-Object -ComObject Wscript.Shell 
# $Output = $wshell.Popup("You have selected: $bucket_location")
# Write-Output $bucketLocation $newPath

# if selection != null, copy to file
If ($newPath -ne $null) {
    Set-Content -Path "$bucketLocation" -Value "$newPath"
}