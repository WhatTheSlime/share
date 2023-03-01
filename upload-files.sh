#/bin/bash
for file in "$@"
do
	name=$(basename $file)
	cat $file | base64 > $name.b64
	zip -FS $name.zip $name.b64
	rm $name.b64
	git add $name.zip
done

git commit -m "Adding multiple files"; git push
