echo BYE!!!

echo killing ssh-agent

if [ -n "$SSH_AUTH_SOCK" ] ; then
  eval `/usr/bin/ssh-agent -k`
fi