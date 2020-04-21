# this plugin copies the current file to the bucket

# this is the default bucket location
$bucket_location = "${HOME}\Desktop\bucket_1"
$bucket_data = "$HOME\yadle\plugins\bucket.txt"

# icon for notify-send messages
#icon="${HOME}/yadle/plugins/logo.png"

# full pathname from Yadle
$fullpath = $args[0]

# allow for pop-up messages
$wshell = New-Object -ComObject Wscript.Shell

# create default bucket or take current bucket data
# leaf for file, container for folder
if (-Not (Test-Path $bucket_data -PathType leaf)) {
    Set-Content -Path "$bucket_data" -Value "$bucket_location"
}

# set bucket_location based on bucket.txt
$bucket_location = Get-Content -Path $bucket_data

# if bucket does not exist, create it
if (-Not (Test-Path $bucket_location -PathType container)) {
    New-Item -Path "$bucket_location" -Type Directory
}

# check for file and copy it to bucket
if (Test-Path $fullpath -PathType leaf) {
    Copy-Item "$fullpath" -Destination "$bucket_location"
    $Output = $wshell.Popup("Copied $fullpath to $bucket_location")
}
else {
    $Output = $wshell.Popup("File not found, please check access and permissions to: $fullpath.")
}

# EOF

