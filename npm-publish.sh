function npublish() {
	if [ ! -f package.json ]; then
		echo "package.json does not exist"
		return 1
	fi
	nameField=`grep "^ *\"name\":" package.json | head -n 1`
	versionField=`grep "^ *\"version\":" package.json | head -n 1`
	version=`echo "$versionField" | cut -f4 -d\"`
	if which npmrc; then
		npmrc
	else
		echo "Note: you don't have npmrc installed"
	fi
	if [ -f .npmrc ]; then
		echo ".npmrc exist at current directory"
	fi
	if [ -n "$*" ]; then
		echo "Your flags: $*"
	fi
	beta=`echo "$version" | cut -f2 -d-`
	if [ -n "$beta" ]; then
		tag=`echo $beta | grep -o "[a-z]*"`
		[ -z "$tag" ] && tag="beta"
		echo "Your version contains -$beta, forcing npm --tag $tag"
		beta="--tag $tag"
	else
		semv=`echo "$version" | grep "^[0-9]\+.[0-9]\+.[0-9]\+$"`
		if [ -z "$semv" ]; then
			echo "Your version $version is not in semver format."
			return 1
		fi
	fi
	reg=`npm $beta $* config get registry`
	echo ""
	echo "== About to publish to NPM registry $reg == "
	echo ""
	echo "Package $nameField"
	echo "Package $versionField"
	echo ""
	echo "Actual command to be executed: npm $beta $* publish"
	echo ""
	echo -n "Press Enter"
	read
	echo -n "Press Enter Again"
	read
	echo "OK, publishing"
	npm $beta $* publish 
}

function nlpublish() {
	npublish --registry http://localhost:4873 $*
}
