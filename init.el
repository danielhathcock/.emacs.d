
;; Better defaults for these values improve emacs performance.
(setq gc-cons-threshold 50000000)
(setq large-file-warning-threshold 100000000)
(setq gnutls-min-prime-bits 4096)

;; File for Custom to edit so it doesn't automatically edit this file
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

(load "~/.emacs.d/initFiles/packages.el")
(load "~/.emacs.d/initFiles/options.el")
