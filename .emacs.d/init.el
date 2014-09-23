;; Initialize packages, with just Melpa as a source.
(require 'package)
(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

;; These are the packages that I want present on all machines.
(setq da-desired-packages
      '(color-theme-approximate
        color-theme-solarized
        color-theme 
        exec-path-from-shell
        gitignore-mode
        go-mode
        js2-mode
        markdown-mode
        protobuf-mode
        yaml-mode
        yasnippet))

;; An implementation of filter, since elisp is from the past and
;; doesn't have one.
(defun da-filter (condp lst)
  (delq nil
        (mapcar (lambda (x) (and (funcall condp x) x)) lst)))

;; Install missing packages before processing the rest of the
;; preferences. Otherwise, the configuration will almost certainly
;; fail to load.
(let ((missing-packages (da-filter (lambda (x) (not (package-installed-p x))) da-desired-packages)))
  (when (not (null missing-packages))
    (if (y-or-n-p (format "Packages %s are missing. Install? " missing-packages))
        (progn
          (package-refresh-contents)
          (mapc 'package-install missing-packages)))))

;; Finally, chain off to other settings, once all packages are
;; available to autoload.
(add-hook 'after-init-hook #'(lambda () (load "~/.emacs.d/preferences.el")))
