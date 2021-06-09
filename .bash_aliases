# General
alias c="clear"
alias claer="clear"
alias la="ls -a"

# GPU
alias dlocpid='echo PID Container;for pid in `nvidia-smi -q -x | grep pid | sed -e "s/<pid>//g" -e "s/<\/pid>//g" -e "s/^[[:space:]]*//"`;do for container in `docker ps --format "{{.Names}}"`;do if (docker top $container|grep -q $pid);then echo $pid $container;fi;done;done;'
alias resource_monitor="tmux new-session\; send-keys 'htop' C-m\; split-window -v -l 30\; send-keys 'watch -n .3 nvidia-smi' C-m\;"

tabs -4
