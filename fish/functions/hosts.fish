# Defined in - @ line 1
function hosts --wraps='sudo vim /private/etc/hosts' --description 'alias hosts=sudo vim /private/etc/hosts'
  sudo vim /private/etc/hosts $argv;
end
