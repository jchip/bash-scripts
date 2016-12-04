IFS=. read _M _t <<< $BASH_VERSION

if [ ! $_M -ge 4 ]; then
	echo "required bash version >= 4"
	exit 1
fi

declare -A mimeTypes

function read_etc_mime_types() {
	while read i; do

		[[ $i =~ ^[:blank:]*\#.*$ ]] && continue  # ignore comment lines
		[[ $i =~ ^[^$'\t']+$'\t'+[^$'\t']+$ ]] || continue # ignore lines without extensions

		# add extensions and type to dictionary

		IFS=\  read -r t x <<< $i
		for ext in $x; do
			mimeTypes["$ext"]="$t"
		done

	done < $1
}

read_etc_mime_types /etc/mime.types

function show_mime_types() {
	for k in ${!mimeTypes[@]}; do
		echo $k = ${mimeTypes[$k]}
	done
}

echo ${mimeTypes[json]}
echo ${mimeTypes[js]}

