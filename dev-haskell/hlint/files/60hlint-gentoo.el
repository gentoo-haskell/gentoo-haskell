
;; hlint emacs integration site initialisation
(add-to-list 'load-path "@SITELISP@")
(require 'hs-lint)
(defun my-haskell-mode-hook ()
   (local-set-key "\C-cl" 'hs-lint))
(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)
