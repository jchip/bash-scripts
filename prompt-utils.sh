#
# show unique command history
#

function uh() {
  history | sed -e 's/  *$//' | sort -b -r -u | sort --key=1.8b -u -b | sort -u -b -n | cut -b8- > /tmp/history_uh.$$
  history -c -r /tmp/history_uh.$$
  rm -f /tmp/history_uh.$$
  history
}
