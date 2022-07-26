alias ll='ls -l'
alias la='ls -lA'
alias l='ls -CF'
alias open=xdg-open

greset() {
    git reset --hard HEAD~$1
}
#GIT
gcommit() {
    git pull
    #do things with parameters like $1 such as
    git branch
    git add .
    git status
    git commit -m "$1"  
}
gpush(){
    gcommit "$1" && git fetch && git push
}
alias pull="git pull"
alias gfetch="git fetch"
alias gmerge="git merge"
alias gbranch="git branch"
tcommit() {
    sh ./test.sh && gcommit "$1"
}
tpush(){
    tcommit "$1" && git fetch && git push
}
gstash(){
    git add .
    git stash $@
}
#DOCKER
alias dimages="docker images"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dprune="docker system prune -af"
ipv4(){
    hostname -I | awk '{print $1}'
}
alias grep="grep --color"
# print neofetch
[[  "$TERM_PROGRAM" != "vscode" ]] && neofetch