function uh() {
  history | sed -e '$ d' | sed -e 's/  *$//' | sort -b -r -n | sed -e 's/^ /-/' | sed -e 's/^- /--/' | sed -e 's/^-- /---/' | sed -e 's/^--- /----/' | sort --key=1.8 -u -b | sed -e 's/^--*//' | sort -n | cut -f3- -d\  | sed -e 's/^  *//' > /tmp/history_uh.$$
  history -c -r /tmp/history_uh.$$
  rm -f /tmp/history_uh.$$
  history
}
