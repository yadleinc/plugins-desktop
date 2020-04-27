# this plugin opens the selected file in the Windows Explorer

# full pathname from Yadle
$fullpath = $args[0]

# return the file path without file name
$directory1 = (Get-Item $fullpath).DirectoryName

# open in explorer
start cmd "/k pushd $directory1"

# EOF

