#
# http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x405.html
#

function xtput() {
  local X="$*"
  X=${X/black/0}
  X=${X/red/1}
  X=${X/green/2}
  X=${X/yellow/3}
  X=${X/blue/4}
  X=${X/magenta/5}
  X=${X/cyan/6}
  X=${X/white/7}
  X=${X/fc/setaf}
  X=${X/bc/setab}
  X=${X/ul:on/smul}
  X=${X/ul:off/rmul}
  X=${X/ul:1/smul}
  X=${X/ul:0/rmul}
  X=${X/\%/sgr0}
  for s in $X; do
    tput $(echo -n $s | cut -f1- -d: --output-delimiter=\ )
  done
}

function etput() {
  local C=$1
  local N=""
  [[ $C == *"n:0"* ]] && N="-n" && C=${C/n:0/}
  [ "$C" != "" ] && xtput $(echo $C | cut -f1 -d@)
  shift
  [ "$*" != "" ] && echo $N "$*"
  local X=$(echo $C | cut -f2 -d@ -s)
  [ "$X" != "" ] && xtput $X
}

etput "n:0 bold fc:green ul:on" Blah: hello green and underline
etput "fc:cyan ul:off" " On same line: Hello cyan"
etput "fc:magenta" "Hello Magenta"
etput "ul:1 fc:white bc:cyan" white underline
etput @% "continue same attr - whatever"
etput "ul:0 rev" reverse underline off
etput @% "reset after this"
etput @ "All reset"

