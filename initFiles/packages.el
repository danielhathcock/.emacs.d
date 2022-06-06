;; Setup Emacs package manager
(require 'package)
(setq package-archives '(("melpa"     . "http://melpa.org/packages/")
                         ("gnu"       . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; use-package allows for easier package configuration and lazy-loading
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Doom theme (VS code theme)
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config))


;; Smarter mode line (little line below each major buffer with info about the buffer)
(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/theme 'dark)
  (add-hook 'after-init-hook 'sml/setup))


;; Ido makes the mini-buffer more useful. Adds iteractivity and autocompletion
(use-package ido
  :ensure t
  :init  (setq ido-enable-flex-matching t
               ido-use-virtual-buffers t
               ido-everywhere t)
  :config 
  (ido-mode 1)
  (ido-everywhere 1)
  (defun bind-ido-keys ()
    "Keybindings for ido mode."
    (define-key ido-completion-map (kbd "<C-backspace>") 'ido-delete-backward-word-updir))
  (add-hook 'ido-setup-hook #'bind-ido-keys))

(use-package ido-vertical-mode
  :ensure t
  :init (setq ido-vertical-define-keys 'C-n-C-p-up-and-down)
  :config
  (ido-vertical-mode 1))

;; Smarter Meta-x
(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)))

;; Allows you to not display certain info in the mode line (like certain minor modes)
(use-package diminish
  :ensure t)

;; Highlight matching parens
(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)
    (show-paren-mode t)))


;; Add small suggestions on which keystrokes may come next
(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode +1))

;; Ctrl-Z for undo, and smarter undo
(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :init
  (global-undo-tree-mode 1)
  :config
  (defalias 'redo 'undo-tree-redo)
  ;; (global-set-key (kbd "C-/") 'comment-line)
  :bind (("C-z" . undo)     ; Zap to character isn't helpful
         ("C-S-z" . redo)
         :map undo-tree-map
         ("C-/" . comment-line)))  ; Have to rebind this *after* undo-tree is loaded, so do it in undo-tree keymap

;; multiple-cursors - allows for multiple cursors which can be added to match the
;; current selection
(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-m" . mc/mark-all-like-this)
         ("C-S-c C-S-c" . mc/edit-lines)))

;; Intelligently delete whitespace
;; (use-package smart-hungry-delete
;;   :ensure t
;;   :bind (("<backspace>" . smart-hungry-delete-backward-char)
;;          ("<delete>" . smart-hungry-delete-forward-char))
;;   :defer nil ;; dont defer so we can add our functions to hooks 
;;   :config (smart-hungry-delete-add-default-hooks)
;;   )



(use-package python
  :mode ("\\.py\\'" . python-mode)
        ("\\.sage$" . python-mode)
  
  :init
  (setq-default indent-tabs-mode nil)

  :config
  (setq python-indent-offset 4)
  (add-hook 'python-mode-hook 'smartparens-mode))


(use-package racket-mode
  :ensure t)

;; Update packages automatically
(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (setq auto-package-update-prompt-before-update t)
  (auto-package-update-maybe))
