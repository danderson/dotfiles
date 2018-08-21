(setq custom-file "~/.emacs.d/customize.el")
(load custom-file)

(load "~/.emacs.d/google-coding-style.el")

;; For JSX and javascript crap, you need NPM stuff installed.
;;
;; http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html

(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tsx$" . web-mode))

(add-hook 'before-save-hook 'gofmt-before-save)

(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'writegood-mode)

(color-theme-initialize)
(color-theme-solarized)
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

(require 'flycheck)
(global-flycheck-mode)
(flycheck-add-mode 'javascript-eslint 'web-mode)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(add-hook 'js2-mode-hook #'setup-tide-mode)

(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "jsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "js")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

;; Enable direnv support globally as a minor mode.
(direnv-mode)

;; If a local configuration file is available, load that right at the
;; end to override/complement settings.
(if (file-regular-p "~/.emacs-machine.el")
    (load "~/.emacs-machine.el"))
