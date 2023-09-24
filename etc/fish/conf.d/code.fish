if set -q TERM_PROGRAM
   if test $TERM_PROGRAM = vscode
      set -x VISUAL "code --wait"
   end
end