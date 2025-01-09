git config --global log.date relative
git config --global format.pretty "format:%C(yellow)%h %Cblue%>(12)%ad %Cgreen%<(7)%aN %Creset%s%Cred%d"

# Show recent branches
git config --global alias.lb "!git for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))' --count=\${1:-15}"