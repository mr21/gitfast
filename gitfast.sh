#!/bin/bash
# GitFast - 1.0.0
# https://github.com/Mr21/gitfast

###########################################################
###########################################################

# private :

gf__clear_active=true
gf__clear() {
	if [[ $gf__clear_active = true ]]; then
		clear
	fi
}
gf__status() {
	b=`git symbolic-ref HEAD --short`
	n=`git cherry | wc -l | sed 's/ //g'`
	echo "# $b / $n"
	git status --short
}

###########################################################
###########################################################

# gbl : git branch listing
# gbs : git branch selection
# gbn : git branch new

gf_branch_listing() {
	gf__clear
	if [[ -z $1 ]]; then
		\git branch
	else
		\git branch | \grep $1 | \sed 's/..\(.*\)/\1/'
	fi
}
alias gbl=gf_branch_listing

gf_branch_selection() {
	if [[ $1 ]]; then
		branch=`\git branch | \grep $1 | \head -n 1 | \sed 's/..\(.*\)/\1/'`
		if [[ -z $branch ]]; then
			gf__clear
			\git branch
		else
			\git checkout $branch &&
			gf__clear &&
			\git branch
		fi
	fi
}
alias gbs=gf_branch_selection

gf_branch_new() {
	gf__clear
	if [[ $1 ]]; then
		\git checkout -b "$1" &&
		gf__clear &&
		\git branch
	fi
}
alias gbn=gf_branch_new

###########################################################
###########################################################

gf_add() {
	if [[ $1 ]]; then git add "$@"
	             else git add -A; fi
	gf__clear
	gf__status
}
gf_addP() {
	gf__clear
	git add -p "$@"
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

alias gad=gf_add
alias gap=gf_addP
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
