How-to
======

## Steps to encode, zip and upload a file

```bash
# 1. set file path
file="/path/to/binary"
name=$(basename $file)

# 2. encode binary in base64 and put it in a file
cat $file | base64 > files/$name.b64

# 3. compress the file
zip -FS files/$name.zip files/$name.b64

# 4. delete the file
rm files/$name.b64

# 5. add, commit and push
git add files/$name.zip
git commit -m "Adding $name.zip"
git push
```

## Script to encode, zip and upload multiple files

```bash
./upload-files.sh "/path/to/file1" "/path/to/file2" ...
```

## Steps to download, unzip and decode a file

*Bash*
```bash
# 1. set file name (without .zip)
file="binary_name"

# 2. download zipfile from github
wget https://github.com/WhatTheSlime/share/raw/main/$file.zip

# 3. unzip zipfile
unzip $file.zip

# 4. decode file from base64
cat $file.b64 | base64 -d > $file

# 5. delete useless files
rm $file.zip $file.b64
```

*Powershell*
```ps1
# 1. set file name (without .zip)
$file="binary_name"

# 2. download zipfile from github
(New-Object net.webclient).Downloadfile("https://github.com/WhatTheSlime/share/raw/main/$file.zip", "$file.zip")

# 3. unzip zipfile
Expand-Archive "$file.zip" .

# 4. decode file from base64
[IO.File]::WriteAllBytes($file, ([convert]::FromBase64String(([IO.File]::ReadAllText("$file.b64")))))

# 5. delete useless files
rm "$file.zip","$file.b64"
```

## Function to download, unzip and decode multiple files

*Bash*
```bash
# definition
get-files () {
	for file in "$@"
	do
		wget https://github.com/WhatTheSlime/share/raw/main/$file.zip
		unzip $file.zip
		cat $file.b64 | base64 -d > $file
		rm $file.zip $file.b64
	done
}

# usage
get-files "file1" "file2" ...
```

*Powershell*
```ps1
# definition
function Get-Files {
	foreach ($file in $args) {
		(New-Object net.webclient).Downloadfile("https://github.com/WhatTheSlime/share/raw/main/$file.zip", "$file.zip")
		Expand-Archive "$file.zip" .
		[IO.File]::WriteAllBytes($file, ([convert]::FromBase64String(([IO.File]::ReadAllText("$file.b64")))))
		rm "$file.zip","$file.b64"
	}
}

# usage
Get-Files "file1","file2",...
```