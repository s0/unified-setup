;; Use UTF-8 for everything
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

(setq make-backup-files nil) ;;prevent creation of "file~" files (original backup)
(setq auto-save-default nil) ;;prevent creation of "#file#" files (auto backup)

;; Setup Tabs
;; use spaces instead of tabs by default accross all files, and use 4 spaces by default
(setq c-basic-indent 4)
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)

;; Turn on whitespace highlighting
(global-whitespace-mode 1)

(require 'whitespace)
;;(setq whitespace-style '(face trailing tab-mark tabs)) ;; turns on white space mode only for tabs (and also highlights tabs)
(setq whitespace-style '(face trailing tab-mark)) ;; turns on white space mode only for tabs
;;(setq whitespace-line-column 79) ;; limit line length
;;(setq whitespace-style '(face lines-tail)) ;; highlight cpde that goes beyond line length limit

;; Fix java-mode's handling of tabs and indentation
(add-hook 'java-mode-hook (lambda ()
                (setq c-basic-offset 4
                  tab-width 4
                  indent-tabs-mode t)))

;; Enable Bracket Highlighting
(show-paren-mode)
