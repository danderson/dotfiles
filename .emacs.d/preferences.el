(setq custom-file "~/.emacs.d/customize.el")
(load custom-file)

(load "~/.emacs.d/google-coding-style.el")

;; Override js-mode with js2-mode.
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))

(add-hook 'before-save-hook 'gofmt-before-save)

(autoload 'color-theme-approximate-on "color-theme-approximate")
(color-theme-approximate-on)

;; Replace all yes/no questions with y/n.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Move between frames with shift + arrow
(windmove-default-keybindings)

;; X only features.
(when window-system
  ;; Enable wheelmouse support in X.
  (mwheel-install) ; TODO
  ;; Use extended compound-text coding for the X clipboard.
  (set-selection-coding-system 'compound-text-with-extensions)
  ;; Set the default font face to something small and beautiful and
  ;; FontConfiggy
  (set-face-font 'default "Monospace-11")
  ;; Set the execution path to match $PATH in the shell.
  (exec-path-from-shell-initialize))

;; Pretty pretty colors.
(setq default-frame-alist
      '((cursor-color . "white")
        (cursor-type . box)))

;; Engage UTF-8.
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Unset C-z, and C-x C-z, which depending on the OS will minimize
;; and/or SIGSTOP emacs.
(global-unset-key "\C-z")
(global-unset-key "\C-x\C-z")

(global-set-key [(control backspace)] 'kill-this-buffer)
(global-set-key [(meta l)] 'goto-line)
(global-set-key [(meta c)] 'comment-region)
(global-set-key [(meta u)] 'uncomment-region)

;; If a local configuration file is available, load that right at the
;; end to override/complement settings.
(if (file-regular-p "~/.emacs-machine.el")
    (load "~/.emacs-machine.el"))
