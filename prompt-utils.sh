#
# show unique command history
#

function uh() {
  history | sort -b -r -u | sort --key=1.8b -u -b | sort -u -b -n
}
