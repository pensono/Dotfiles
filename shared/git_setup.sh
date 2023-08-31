# Pico/nano in tool mode (disables autosave)
git config --global core.editor "pico -t"

# Show recent branches
git config --global alias.lb "!git for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))' --count=`${1:-15}"