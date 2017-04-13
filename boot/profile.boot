(require 'boot.repl)
(swap! boot.repl/*default-dependencies*
       concat '[[compliment "0.3.4"]
                [refactor-nrepl "2.2.0"]])

