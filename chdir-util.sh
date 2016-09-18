function clearcds()
{
declare -i I=0
dirs -p -l| while read line
     do
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
else
 dir=$1
fi
#echo dir is $dir
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

function dcd()
{
if [ "$1" == "" ]; then
 dirsl
else
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
 
