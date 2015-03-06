#!/bin/bash
# https://github.com/Mr21/gitfast

# conf
gf__clear_active=true

# private functions
gf__clear() {
	if [[ $gf__clear_active = true ]]; then clear; fi
}
gf__status() {
	b=`git symbolic-ref HEAD --short`
	n=`git cherry | wc -l | sed 's/ //g'`
	echo "# $b / $n"
	git status --short
}

# alias functions
gf_branch() {
	if [[ $1 ]]; then git checkout $1; fi
	gf__clear
	git branch
}
gf_add() {
	if [[ $1 ]]; then git add "$@"
	             else git add -A; fi
	gf__clear
	gf__status
}
gf_checkout() {
	if [[ $1 ]]; then git checkout "$@"; fi
	gf__clear
	gf__status
}
gf_commit() {
	if [[ $1 ]]; then m=$1
	             else m='...'; fi
	git commit -m "$m" > /dev/null && gf_log -1
	gf__status
}
gf_status() {
	gf__clear
	gf__status
}
gf_diff() {
	gf__clear
	git diff "$@"
}
gf_log() {
	gf__clear
	git log --oneline "$@"
}
gf_logFull() {
	gf__clear
	git log --stat "$@"
}
gf_pull() {
	gf__clear
	git pull
}
gf_push() {
	gf__clear
	git push "$@"
	gf__status
}
gf_pushForce() {
	gf_push -f
}
gf_resetHead() {
	cmd='git reset HEAD'
	if [[ $1 ]]; then
		for ((i=0; i < $1; ++i)); do cmd+='^'; done
	fi
	gf__clear
	$cmd > /dev/null
	gf__status
}

# aliases
alias gbr=gf_branch
alias gad=gf_add
alias gco=gf_checkout
alias gci=gf_commit
alias gst=gf_status
alias gdf=gf_diff
alias gls=gf_log
alias glf=gf_logFull
alias gpl=gf_pull
alias gps=gf_push
alias gpf=gf_pushForce
alias grh=gf_resetHead
