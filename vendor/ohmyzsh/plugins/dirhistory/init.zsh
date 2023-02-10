# Source module file
if (( ! $+functions[dirhistory] )); then
  source "${0:h}/dirhistory.plugin.sh" || return 1
fi
