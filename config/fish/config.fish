set PATH ~/bin ~/.local/bin ~/.cargo/bin ~/.nimble/bin $PATH

if test -e $HOME/.keychain/(hostname)-fish
    source $HOME/.keychain/(hostname)-fish
end

if test -e /usr/lib/python3.8/site-packages/virtualfish/virtual.fish
    eval (python -m virtualfish)
end

if test -e ~/conda3/etc/fish/conf.d/conda.fish
    source ~/conda3/etc/fish/conf.d/conda.fish
end

eval (dircolors -c ~/.dircolors)
