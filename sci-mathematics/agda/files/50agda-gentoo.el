;;; agda site-lisp configuration

(add-to-list 'load-path "@SITELISP@")
(autoload 'agda-mode "agda-mode.el"
          "Major mode for Agda files" t)
(unless (assoc "\\.agda" auto-mode-alist)
  (setq auto-mode-alist
        (nconc '(("\\.agda" . agda-mode)
                 ("\\.alfa" . agda-mode)) auto-mode-alist)))

