;; Keybindings, lots stolen from Emacs Starter Kit

;; also some wisdom taken from https://sites.google.com/site/steveyegge2/effective-emacs

;; You know, like Readline.
(global-set-key (kbd "C-w") 'backward-kill-word)
;; Since we've unset C-w, map it to something else
(global-set-key (kbd "C-x C-k") 'kill-region)
;; ... and the clumsy version
(global-set-key (kbd "C-c C-k") 'kill-region)

;; Make regex searches easier to use

;; these clash with paredit, so aren't available
(global-set-key (kbd "M-s") 'isearch-forward-regexp)
(global-set-key (kbd "M-r") 'isearch-backward-regexp)

;; File finding
(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-c f") 'find-file-in-project)
(global-set-key (kbd "C-x f") 'recentf-ido-find-file)
(global-set-key (kbd "C-x C-p") 'find-file-at-point)
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "M-`") 'file-cache-minibuffer-complete)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; External applications
(global-set-key (kbd "C-c g") 'magit-status)
(global-set-key (kbd "C-c t") 'bw-start-term)

(defun bw-prevent-old-magit ()
  "Warns me about the keyboard shortcut changing"
  (interactive)
  (message "Use C-c g!"))

(global-set-key (kbd "C-x g") 'bw-prevent-old-magit)

;; map M-x to C-x C-m and C-c C-m
(global-set-key (kbd "C-x C-m") 'execute-extended-command)
(global-set-key (kbd "C-c C-m") 'execute-extended-command)
;; Unset GNUs since it clashes with above and I don't use it
(global-unset-key (kbd "C-x m"))

;; Navigation Flymake errors
(global-set-key (kbd "C-c n") 'flymake-goto-next-error)
(global-set-key (kbd "C-c p") 'flymake-goto-prev-error)

;; force myself to stop using M-x
(defun bw-prevent-m-x ()
  "Stop me from using M-x by warning me"
  (interactive)
  (message "Use C-x C-m!"))

(global-set-key (kbd "M-x") 'bw-prevent-m-x)

;; anti-n00b mode - turn off arrow keys
(mapc 'global-unset-key [[up] [down] [left] [right]])

;; prompt before killing emacs
(defun bw-kill-emacs ()
  "Warn before exiting Emacs"
  (interactive)
  (cond ((y-or-n-p "Quit Emacs? ")
         (save-buffers-kill-emacs))))

(global-set-key (kbd "C-x C-c") 'bw-kill-emacs)
(global-set-key (kbd "C-c x") 'server-edit)

;; Org-mode
(global-set-key (kbd "C-M-r") 'org-capture)

;; use ido search over imenu
(global-set-key (kbd "C-c i") 'idomenu)

;; use hippie expand instead of dabbrev
(global-set-key (kbd "M-/") 'hippie-expand)

;; we want an eshell easily
(global-set-key (kbd "C-c e") 'eshell)
;; always pop a new eshell
(global-set-key (kbd "C-c E") (lambda () (interactive) (eshell t)))
