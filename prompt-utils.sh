#
# show unique command history
#

function uh() {
  history | sort --key=1.8b -u | sort -u -b -n
}
