;; el-get configuration

(defconst package-base-dir
  (bw-join-dirs dotfiles-dir "packages"))
(make-directory package-base-dir t)
(bw-add-to-load-path package-base-dir)

;; my own package definitions
(setq el-get-sources
  '((:name ack-and-a-half :type elpa)
    (:name color-theme-solarized
           :type github
           :pkgname "sellout/emacs-color-theme-solarized"
           :prepare
           (progn
             (add-to-list 'custom-theme-load-path default-directory)
             (autoload 'color-theme-solarized-light "color-theme-solarized"
               "color-theme: solarized-light" t)
             (autoload 'color-theme-solarized-dark "color-theme-solarized"
               "color-theme: solarized-dark" t)))
    (:name diminish :type elpa)
    (:name flymake-cursor :type elpa)
    (:name idomenu :type elpa)
    (:name iedit :type elpa)
    ;; js2-mode changed to be better in Emacs24
    (:name js2-mode
           :type github
           :branch "emacs24"
           :pkgname "mooz/js2-mode"
           :prepare (autoload 'js2-mode "js2-mode" nil t))
    ;; this replaces the built-in package.rcp
    ;; because it clobbers the package-archives
    (:name package
           :builtin 24
           :features package
           :post-init
           (progn
             ;; Gotten from:
             ;; https://github.com/purcell/emacs.d/blob/master/init-elpa.el
             (defadvice package-generate-autoloads
               (after close-autoloads (name pkg-dir) activate)
               "Stop package.el from leaving open autoload files lying around."
               (let ((path (expand-file-name (concat name "-autoloads.el") pkg-dir)))
                 (with-current-buffer (find-file-existing path)
                   (kill-buffer nil))))

             (setq package-archives
                   '(("gnu" . "http://elpa.gnu.org/packages/")
                     ("marmalade" . "http://marmalade-repo.org/packages/")
                     ("melpa" . "http://melpa.milkbox.net/packages/")))
             (defconst package-install-dir
               (bw-join-dirs package-base-dir "elpa"))

             (make-directory package-install-dir t)
             ;; this is to set up packages
             (setq package-user-dir package-install-dir)))
    (:name paredit :type elpa)
    (:name undo-tree :type elpa)))

(defun bw-el-get-cleanup (packages)
  "Remove installed packages not explicitly declared"
  (let* ((packages-to-keep
          (el-get-dependencies (mapcar 'el-get-as-symbol packages)))
         (packages-to-remove
          (set-difference (mapcar 'el-get-as-symbol
                                  (el-get-list-package-names-with-status
                                   "installed")) packages-to-keep)))
    (mapc 'el-get-remove packages-to-remove)))

;; init-* files are stored here
(defconst el-get-base-dir
  (bw-join-dirs package-base-dir "el-get"))

(make-directory el-get-base-dir t)
(setq el-get-dir el-get-base-dir)

(bw-add-to-load-path (bw-join-dirs el-get-base-dir "el-get"))

(eval-after-load 'el-get
  '(progn
     (setq el-get-git-shallow-clone t)))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let ((el-get-master-branch)
          (el-get-install-skip-emacswiki-recipes))
      (goto-char (point-max))
      (eval-print-last-sexp))))

(setq bw-packages
      '(use-package ; this has to come first
         ack-and-a-half
         browse-kill-ring
         color-theme-solarized
         diminish
         eproject
         expand-region
         flymake-cursor
         git-modes
         idomenu
         iedit
         js2-mode
         magit
         magithub
         multiple-cursors
         paredit
         rhtml-mode
         smex
         undo-tree
         web-mode
         yasnippet))

(el-get 'sync bw-packages)

(provide 'init-el-get)