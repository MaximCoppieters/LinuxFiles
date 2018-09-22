# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# If you want to use a Palm device with Linux, uncomment the two lines below.
# For some (older) Palm Pilots, you might need to set a lower baud rate
# e.g. 57600 or 38400; lowest is 9600 (very slow!)
#
#export PILOTPORT=/dev/pilot
#export PILOTRATE=115200

test -s ~/.alias && . ~/.alias || true

#Oracle database startup

alias dbstart='/u01/app/oracle/product/11.2.0/xe/config/scripts/startdb.sh'

#. /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh

alias sql='cd ~/Desktop/Vakken/data/ && sleep 0.1; rlwrap sqlplus'

alias jzip='java -jar ~/bin/Zipping.jar'
alias python='python3.6'
alias javamap='cd ~/Desktop/Vakken/java_essentials/oplossingen'
alias intelliJ='/usr/bin/intelliJ/bin/idea.sh'

export CLASSPATH=$CLASSPATH:~/Documents/Misc/algs4.jar

source /etc/environment
# Shell prompt based on the Solarized Dark theme.
# Screenshot: http://i.imgur.com/EkEtphC.png
# Heavily inspired by @necolas’s prompt: https://github.com/necolas/dotfiles
# iTerm → Profiles → Text → use 13pt Monaco with 1.1 vertical spacing.

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color';
fi;

prompt_git() {
	local s='';
	local branchName='';

	# Check if the current directory is in a Git repository.
	if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

		# check if the current directory is in .git before running git checks
		if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

			# Ensure the index is up to date.
			git update-index --really-refresh -q &>/dev/null;

			# Check for uncommitted changes in the index.
			if ! $(git diff --quiet --ignore-submodules --cached); then
				s+='+';
			fi;

			# Check for unstaged changes.
			if ! $(git diff-files --quiet --ignore-submodules --); then
				s+='!';
			fi;

			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				s+='?';
			fi;

			# Check for stashed files.
			if $(git rev-parse --verify refs/stash &>/dev/null); then
				s+='$';
			fi;

		fi;

		# Get the short symbolic ref.
		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
			git rev-parse --short HEAD 2> /dev/null || \
			echo '(unknown)')";

		[ -n "${s}" ] && s=" [${s}]";

		echo -e "${1}${branchName}${2}${s}";
	else
		return;
	fi;
}

if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	# Solarized colors, taken from http://git.io/solarized-colors.
	black=$(tput setaf 0);
	blue=$(tput setaf 153);
	green=$(tput setaf 71);
	orange=$(tput setaf 166);
	red=$(tput setaf 167);
	white=$(tput setaf 15);
	yellow=$(tput setaf 228);
else
	bold='';
	reset="\e[0m";
	black="\e[1;30m";
	blue="\e[1;34m";
	green="\e[1;32m";
	orange="\e[1;33m";
	red="\e[1;31m";
	white="\e[1;37m";
	yellow="\e[1;33m";
fi;

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
	userStyle="${red}";
else
	userStyle="${orange}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="${bold}${red}";
else
	hostStyle="${yellow}";
fi;

# Set the terminal title to the current working directory.
PS1="\[\033]0;\w\007\]";
PS1+="\[${bold}\]\n"; # newline
PS1+="\[${userStyle}\]\u"; # username
PS1+="\[${white}\] at ";
PS1+="\[${hostStyle}\]\h"; # host
PS1+="\[${white}\] in ";
PS1+="\[${green}\]\W"; # working directory
PS1+="\$(prompt_git \"\[${white}\] on \[${blue}\]\" \"\[${blue}\]\")"; # Git repository details
PS1+="\n";
PS1+="\[${white}\]\$ \[${reset}\]"; # `$` (and reset color)
export PS1;

PS2="\[${yellow}\]→ \[${reset}\]";
export PS2;


[[ -s "/home/maximcoppieters/.gvm/scripts/gvm" ]] && source "/home/maximcoppieters/.gvm/scripts/gvm"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/maximcoppieters/.sdkman"
[[ -s "/home/maximcoppieters/.sdkman/bin/sdkman-init.sh" ]] && source "/home/maximcoppieters/.sdkman/bin/sdkman-init.sh"

#Added for fresh Oracle 12cR2 Installation
#export ORACLE_HOSTNAME=
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE
#export JAVA_HOME=/usr/lib64/jvm/jdk-10.0.2
export SCALA_HOME=/usr/share/scala
export DART_HOME=~/dev/dart-sdk
export FLUTTER_HOME=~/dev/flutter
export PATH=$HOME/.pub-cache/bin:$DART_HOME/bin:$FLUTTER_HOME/bin:$SCALA_HOME/bin:$JAVA_HOME/bin:$ORACLE_HOME/bin:$PATH:

alias cleardownloads="java -jar ~/dev/jars/DownloadsClearer.jar"
alias sql="rlwrap sqlplus"
alias diag="cd $ORACLE_BASE/diag/rdbms/$ORACLE_UNQNAME/$ORACLE_SID/trace"
alias wiki="~/dev/TiddlyDesktop/nw &> /dev/null &"

#Custom History size changes

export HISTSIZE=-1
export HISTFILESIZE=-1

