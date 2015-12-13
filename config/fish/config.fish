if test -e $HOME/.keychain/(hostname)-fish
    source $HOME/.keychain/(hostname)-fish
end

if test -e /usr/share/virtualfish/virtual.fish
    source /usr/share/virtualfish/virtual.fish
end

eval (dircolors -c ~/.dircolors)
