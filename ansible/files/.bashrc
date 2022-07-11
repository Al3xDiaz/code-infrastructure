alias ll='ls -l'
alias la='ls -lA'
alias l='ls -CF'

alias open=xdg-open

gcommit() {
    #do things with parameters like $1 such as
    git branch
    git add .
    git status
    git commit -m "$1"  
}
gpush(){
    gcommit "$1" && git push
}
alias pull="git pull"
alias gfetch="git fetch"
alias gmerge="git merge"
alias grest="git reset --mixed HEAD~1"
alias gbranch="git branch"
tcommit() {
    sh ./test.sh && gcommit "$1"
}
tpush(){
    tcommit "$1" && git push
}
gstash(){
    git add .
    git stash $@
}
ipv4(){
    hostname -I | awk '{print $1}'
}
alias grep="grep --color"

ipv4(){
    hostname -I | awk '{print $1}'
}
alias grep="grep --color"

#if not repository
if [ ! -d .git ]; then
    neofetch
fi