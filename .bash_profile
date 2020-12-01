###############################################
# Optional settings
###############################################
# Automatically highlight matches with grep
# export GREP_OPTIONS=--color=auto
# Override the default ls colors
# export LS_COLORS="no=00:fi=00:di=01;34:ln=00;36:pi=40;32:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31:ex=00;32:"

export EDITOR="vim"

# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi
# source the users profile if it exists
if [ -f "${HOME}/.profile" ] ; then
  source "${HOME}/.profile"
fi

# Set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/.local/bin:${PATH}"
fi

export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python"

prompt_cmd () {
  ps1_time="\[\033[38;5;14m\][\A]"
  ps1_user="\[\]\[\033[38;5;10m\]\u"
  ps1_host="\h"
  ps1_dir="\[\033[38;5;10m\][\[\]\[\033[38;5;11m\]\w\[\]\[\033[38;5;10m\]]\[\]"
  ps1_prompt="\[\033[38;5;10m\]\$\[\]"
  ps1_clear="\[\033[38;5;15m\]"
  PS1="$ps1_time $ps1_user@$ps1_host $ps1_dir $branch$ps1_prompt$ps1_clear "
}

export PROMPT_COMMAND=prompt_cmd

export WSLENV=$WSLENV
