# find all duplicates
function clearcds()
{
	declare -i I=0
	dirs -p -l | while read line; do
		if [ "$line" == "$1" ]; then
			echo $I
		fi
		I=$I+1
	done
}

function addcd()
{
if [ "$1" == "" ]; then
 dir=~
elif [ "$1" == "." ]; then
 return
elif [ "$1" == "-" ]; then
 bcd 1
 return
else
 dir=$1
fi
#echo dir is $dir
if [ ! -d "$dir" ]; then
 dir=`dirname "$dir"`
fi
declare -i F=0 #offset
declare -i X
d="`dirs -l +0`"
if [ "$dir" == "$d" ]; then
# echo curdir
 return 0
fi
pushd $dir > /dev/null
if [ "$?" == "0" ]; then
 d="`dirs -l +0`"
# echo changed to $d
 pops="`clearcds $d`"
 for i in $pops; do
   X=$i-$F
   popd +$X > /dev/null
   F=$F+1
 done
 pushd $d > /dev/null
 X="`dirs -p | wc -l`"
 if [ $X -gt 50 ]; then
  echo too many... cleaning up
  while test $X -gt 25; do
   popd -0 > /dev/null
   X=X-1
  done
 fi
fi
}

function btcd()
{
	f1=`echo "$1" | cut -f1 -d/`
	if [ "$f1" == "BT" -a ! -d "BT" ]; then
		ndir=$BT/`echo "$1" | cut -f2- -d/`
		addcd "$ndir"
	else
		addcd "$1"
	fi
}

function bcd()
{
if [ "$1" == "" ]; then
 dirsl
else
  dir="`dirs -p -l +$1`"
  if [ $? == 0 ]; then
   addcd $dir
  else
   echo -n $dir
  fi
fi
}

function gcd()
{
	if [ "$1" == "" ]; then
		dirsl
	else
		dir="`dirs -p -l +$1`"
		if [ $? == 0 ]; then
			echo $dir
			export gcd=$dir
			export GCD=$dir
		else
			echo -n $dir
		fi
	fi
}

function dcd()
{
	if [ "$1" == "" ]; then
		dirsl
	elif [ "`dirs -p | wc -l | tr -d [\ ]`" != "1" ]; then
		popd +$1 > /dev/null
	fi
}

function dirsl()
{
	if [ "$1" != "" ]; then
		dirs -p -v | head -$1
	else
		dirs -p -v | head
	fi
}
 
function xcd()
{
	term_size=`stty size`
	menu_height=$[`echo $term_size | cut -f1 -d\ ` - 7]
	dialog --no-shadow --default-item 1 --menu cd $term_size $menu_height `dirs -v | xargs` 2> /tmp/xcd$$
	XCD=`cat /tmp/xcd$$`
	if [ "$XCD" != "" ]; then
		bcd $XCD
	fi
	rm /tmp/xcd$$
}

function xdcd()
{
	term_size=`stty size`
	menu_height=$[`echo $term_size | cut -f1 -d\ ` - 7]
	dialog --no-shadow --checklist dcd $term_size $menu_height `dirs -v | xargs -i echo -n {} "off "` 2> /tmp/xdcd$$
	XDCD=`cat /tmp/xdcd$$ | tr -d [\"] | rev`
	if [ "$XDCD" != "" ]; then
		for x in $XDCD; do
			dcd $x
		done
	fi
	rm /tmp/xdcd$$
}
