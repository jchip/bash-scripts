function git_branch() {
        if [ -n "$1" ]; then
                git checkout $1
        else
                git branch
        fi
}

alias bdev="git checkout develop"
alias bmas="git checkout master"
alias mdev="git merge develop"
alias mmas="git merge master"
alias b=git_branch
alias gitpush="git push && git push --tags"
alias gs="git status"
alias gd="git diff"
alias gl="git log"
