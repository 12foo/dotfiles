set PATH ~/bin ~/.cargo/bin $PATH

if test -e $HOME/.keychain/(hostname)-fish
    source $HOME/.keychain/(hostname)-fish
end

if test -e /usr/lib/python3.6/site-packages/virtualfish/virtual.fish
    eval (python -m virtualfish)
end

eval (dircolors -c ~/.dircolors)
