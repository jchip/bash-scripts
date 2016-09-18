#
# show unique command history
#

function uh() {
  history | sort -b -r -n | sort --key=1.8b -u | sort -u -b -n
}
