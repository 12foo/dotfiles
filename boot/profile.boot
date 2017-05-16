(require 'boot.repl)
(swap! boot.repl/*default-dependencies*
       concat '[[compliment "0.3.4"]
                [proto-repl "0.3.1"]
                [refactor-nrepl "2.2.0"]])

