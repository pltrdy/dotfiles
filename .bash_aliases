# Listing files the right way
alias ls='ls -hF --color'
alias ll='ls -l' 
alias lt='ll -ct'
alias lrt='ls -lrt'

# About directories
alias cdd='cd `ls -t | head -1`'

# Text editors
alias emacs='emacs -nw'

# Pythonic tricks
alias prettyjson='python -m json.tool $1'
