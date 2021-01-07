set PATH ~/bin ~/.local/bin ~/.cargo/bin ~/.nimble/bin $PATH
set EDITOR vim

if test -e $HOME/.keychain/(hostname)-fish
    source $HOME/.keychain/(hostname)-fish
end

eval (dircolors -c ~/.dircolors)
