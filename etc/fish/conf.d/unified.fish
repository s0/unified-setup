# This file is run by all fish instances.
# To include configuration only for login shells, use
# if status --is-login
#    ...
# end
# To include configuration only for interactive shells, use
# if status --is-interactive
#   ...
# end

# motd
# ====

if status --is-login
   # TODO: print sparknet ASCII
   echo 'welcome!'
end

# prompt
# ======

function fish_prompt
  if [ (whoami) = 'root' ]
    set_color -o yellow
    echo -n (prompt_hostname)
  else if [ (whoami) = 'sam' ]
    set_color -o magenta
    echo -n (prompt_hostname)
  else if [ (whoami) = 'anon' ]
    set_color -o red
    echo -n (prompt_hostname)
  else
    set_color -o blue
    echo -n $USER
    set_color normal
    echo -n '@'
    set_color -o magenta
    echo -n (prompt_hostname)
  end


  set_color -o cyan
  echo -n ' '(prompt_pwd)

  set_color -o red
  __fish_git_prompt ' (%s)'

  set_color -o yellow
  echo -n ' > '
  set_color normal
end

# autocomplete settings
# =====================

if command -sq gulp
  gulp --completion=fish | source
end

# environment variables
# =====================

switch (uname)
    case Darwin
        set -x LS_OPTIONS '--color=auto -h'
	set -x EDITOR "emacs"
    case '*'
        set -x LS_OPTIONS '--color=auto --group-directories-first -h --time-style=long-iso'
	set -x EDITOR "emacs -nw -l /unified-setup/config/emacs/.emacs"
end

set -x VISUAL $EDITOR
set -x UAEDITOR $EDITOR
set -gx PATH ~/.bin ~/.local/bin /unified-setup/bin $PATH (yarn global bin)


# aliases + abbreviations
# =======================

alias a='atom'
alias v='vscode'
alias e=$EDITOR
alias x='xdg-open'
alias rm='rm -i'
alias mv='mv -i'

switch (uname)
    case Darwin
        alias ls='ls --color=auto -h'
	alias ibrew='arch -x86_64 /usr/local/bin/brew'
    case '*'
        alias ls='ls --color=auto --group-directories-first -h --time-style=long-iso'
end

alias ll='ls -l'
alias l='ls -la'
alias grep='grep --color'
alias su='su -l'
alias aurget='aurget --config /unified-setup/home/.config/aurgetrc'

alias ruby-dev='/unified-setup/docker/ruby-dev/ruby-dev'

abbr --add g 'git'
abbr --add gs 'git status'
abbr --add ga 'git add -A'
abbr --add gc 'git commit'
abbr --add gco 'git checkout'
abbr --add gd 'git diff'
abbr --add gdt 'git difftool -d'
abbr --add gdc 'git diff --cached'
abbr --add gl 'git log'
abbr --add gb 'git branch -vv'

# functions
# =========

function gprune
 git branch --merged | grep -v "\*" | grep -v -P "(master)|(staging)|(develop)" | tee /tmp/branchprune | xargs -n 1 git branch -d
end

function gpr --description "check out the given pull request"
  set PR $argv[1]
  git update-ref -d refs/pull/$PR/head
  git fetch origin refs/pull/$PR/head:refs/pull/$PR/head
  git checkout refs/pull/$PR/head
end

function geu
  set root (git rev-parse --show-toplevel)
  for f in (git diff --name-only --diff-filter=U)
    set path $root/$f
    set ext (echo $f | sed 's/.*\.//')
    if [ $ext = "java" ];
      echo "can't open in eclipse"
      echo $path
    else
      vscode $path
    end
  end
end

function vgrep
  for result in (grep -Rn $argv[1])
    set file_and_line (echo $result | sed -E 's/^([^:]*)\:([0-9]+)\:(.*)$/\1:\2/')
    set match (echo $result | sed -E 's/^([^:]*)\:([0-9]+)\:(.*)$/\3/')
    echo $file_and_line
    echo '  ' $match
    read -l -p 'echo "Open? (Y/n):"' confirm

    switch $confirm
      case '' Y y
        v -g $file_and_line
    end
  end
end

function s
  set pwd (pwd)
  su - -c "cd $pwd; fish"
end

function eslint-and-prettier-changes
    set diff (git diff --cached --name-only);
    if test -n "$diff"
      npx --no-install eslint (git diff --cached --name-only);
      npx --no-install prettier --write (git diff --cached --name-only);
    else
      echo "no changes";
    end
end

function eslint-and-prettier-prev
    set diff (git diff HEAD~1 --name-only);
    if test -n "$diff"
      npx --no-install eslint (git diff HEAD~1 --name-only);
      npx --no-install prettier --write (git diff HEAD~1 --name-only);
    else
      echo "no changes";
    end
end

atuin init fish | source
