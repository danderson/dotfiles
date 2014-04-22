;; Sets Google's C/C++ coding style, because I like it.
;; da-guess-c-style is hooked up by customize.

(defun da-c-lineup-expression-plus-4 (langelem)
  (save-excursion
    (back-to-indentation)
    ;; Go to beginning of *previous* line:
    (c-backward-syntactic-ws)
    (back-to-indentation)
    ;; We are making a reasonable assumption that if there is a control
    ;; structure to indent past, it has to be at the beginning of the line.
    (if (looking-at "\\(\\(if\\|for\\|while\\)\\s *(\\)")
        (goto-char (match-end 1)))
    (vector (+ 4 (current-column)))))

(c-add-style "google-c-style"
             `((c-recognize-knr-p . nil)
               (c-basic-offset . 2)
               (indent-tabs-mode . nil)
               (c-comment-only-line-offset . 0)
               (c-hanging-braces-alist
                . ((defun-open after)
                   (defun-close before after)
                   (class-open after)
                   (class-close before after)
                   (namespace-open after)
                   (inline-open after)
                   (inline-close before after)
                   (block-open after)
                   (block-close . c-snug-do-while)
                   (extern-lang-open after)
                   (extern-lang-close after)
                   (statement-case-open after)
                   (substatement-open after)))
               (c-hanging-colons-alist
                . ((case-label)
                   (label after)
                   (access-label after)
                   (member-init-intro before)
                   (inher-intro)))
               (c-hanging-semi&comma-criteria
                . (c-semi&comma-no-newlines-for-oneline-inliners
                   c-semi&comma-inside-parenlist
                   c-semi&comma-no-newlines-before-nonblanks))
               (c-indent-comments-syntactically-p . t)
               (comment-column . 40)
               (c-indent-comment-alist . ((other . (space . 2))))
               (c-cleanup-list
                . (brace-else-brace
                   brace-elseif-brace
                   brace-catch-brace
                   empty-defun-braces
                   defun-close-semi
                   list-close-comma
                   scope-operator))
               (c-offsets-alist
                . ((arglist-intro da-c-lineup-expression-plus-4)
                   (func-decl-cont . ++)
                   (member-init-intro . ++)
                   (inher-intro . ++)
                   (comment-intro . 0)
                   (arglist-close . c-lineup-arglist)
                   (topmost-intro . 0)
                   (block-open . 0)
                   (inline-open . 0)
                   (substatement-open . 0)
                   (statement-cont . c-lineup-assignments)
                   (label . /)
                   (case-label . +)
                   (statement-case-open . +)
                   (statement-case-intro . +) ; case w/o {
                   (access-label . /)
                   (innamespace . 0)))))

(setq da-c-styles-alist
      '((nil . "google-c-style")
        ;; Example of setting a different style for a specific
        ;; project. Set it above the default value.
        ;("libcpu" . "bsd-short-indent")
        ))

(defun da-guess-c-style ()
  (let ((style (assoc-default buffer-file-name da-c-styles-alist
                              (lambda (pattern path)
                                (or (not pattern)
                                    (and (stringp path)
                                         (string-match pattern path)))))))
    (c-set-style style)))
