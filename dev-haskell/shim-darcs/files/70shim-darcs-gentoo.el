;;; dev-haskell/shim-darcs site file initialisation

(add-to-list 'load-path "@SITELISP@")
(add-hook 'haskell-mode-hook
          (lambda ()
            (require 'shim)))