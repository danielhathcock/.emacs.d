;; Decrease useless visual clutter
(menu-bar-mode -1)
(tool-bar-mode -1)
;; (toggle-scroll-bar -1)

;; Line numbers
(global-hl-line-mode +1)
(line-number-mode +1)
(global-display-line-numbers-mode 1)


;; No emacs startup screen
(setq inhibit-startup-screen t)

;; Never have to type 'yes'
(fset 'yes-or-no-p 'y-or-n-p)


;; Better scrolling
(setq scroll-step 1)
(setq scroll-conservatively 1000)
(setq auto-window-vscroll nil)

;; C-h b (or M-x describe-bindings) will show all commands for a key combination
;; C-h f (or M-x describe-function) will show the key bindings for a command
(global-set-key (kbd "C-h f") 'describe-function)

;; comment selected region
;; (bind-key* "C-/" 'comment-line)
;; Note: We don't use above to rebind C-/ because this prevents undo-tree from loading. Instead, rebind it in the undo-tree-map (see packages.el)
(bind-key* "M-/" 'comment-line)

;; Better backward-kill-word to not jump lines
(defun backward-kill-char-or-word ()
  (interactive)
  (cond 
   ((looking-back (rx (char word)) 1)
    (backward-kill-word 1))
   ((looking-back (rx (char blank)) 1)
    (delete-horizontal-space t))
   (t
    (backward-delete-char 1))))
(bind-key "<C-backspace>" 'backward-kill-char-or-word)

;; Make ESC quit things like C-g
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

;; default variables for programming language modes
(setq-default c-default-style "linux" ;; nicer default syntax correction
              c-basic-offset 4 ;; set the c offset to 4 spaces
              tab-width 4 ;; set tab width to 4 spaces
              indent-tabs-mode nil ;; use spaces not tab characters
              )

(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq tab-width 4)))


;; Delete highlighted text when press backspace
(delete-selection-mode t)

;; Delete subwords with Ctrl-backspace
(add-hook 'c-mode-common-hook 'subword-mode)
(add-hook 'java-mode-hook 'subword-mode)
(add-hook 'python-mode-hook 'subword-mode)
