;; Much of this is from http://viget.com/extend/emacs-24-rails-development-environment-from-scratch-to-productive-in-5-minu

(setq warning-minimum-level :emergency)

(push "/usr/local/bin" exec-path)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(delete-selection-mode t)

(which-function-mode 1)

;; if needed for mac issues
(if window-system
 (progn
   (scroll-bar-mode -1)
   (tool-bar-mode -1)
   (set-fringe-style -1)
   (tooltip-mode -1)
   ))

(blink-cursor-mode t)
(show-paren-mode t)
(column-number-mode t)

;; aesthetics bullshit
;; (set-frame-font "Menlo-16")
(load-theme 'manoj-dark)

;; el-get ELPA stuff
(require 'package)
(setq package-archives (cons '("tromey" . "http://tromey.com/elpa/") package-archives))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
          ("melpa-stable" . "http://stable.melpa.org/packages/")))))

(add-to-list 'load-path "~/.emacs.d/el-get")
(require 'el-get)

;; ruby-mode/etc stuff

(defun ruby-mode-hook ()
  (autoload 'ruby-mode "ruby-mode" nil t)
  (add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
  (add-hook 'ruby-mode-hook '(lambda ()
                               (setq ruby-deep-arglist t)
                               (setq ruby-deep-indent-paren nil)
                               (setq c-tab-always-indent nil)
                               (require 'inf-ruby)
                               (require 'ruby-compilation))))
(defun rhtml-mode-hook ()
  (autoload 'rhtml-mode "rhtml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
  (add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))
  (add-hook 'rhtml-mode '(lambda ()
                           (define-key rhtml-mode-map (kbd "M-s") 'save-buffer))))
(defun yaml-mode-hook ()
  (autoload 'yaml-mode "yaml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))
(defun css-mode-hook ()
  (autoload 'css-mode "css-mode" nil t)
  (add-hook 'css-mode-hook '(lambda ()
                              (setq css-indent-level 2)
                              (setq css-indent-offset 2))))

;; el-get config


;; (setq el-get-sources
;;       '((:name ruby-mode
;;                :type elpa
;;                :load "ruby-mode.el")
;;         (:name inf-ruby  :type elpa)
;;         (:name ruby-compilation :type elpa)
;;         (:name css-mode :type elpa)
;;         (:name textmate
;;                :type git
;;                :url "git://github.com/defunkt/textmate.el"
;;                :load "textmate.el")
;;         (:name rvm
;;                :type git
;;                :url "http://github.com/djwhitt/rvm.el.git"
;;                :load "rvm.el"
;;                :compile ("rvm.el")
;;                :after (lambda() (rvm-use-default)))
;;         (:name rhtml
;;                :type git
;;                :url "https://github.com/eschulte/rhtml.git"
;;                :features rhtml-mode)
;;         (:name yaml-mode
;;                :type git
;;                :url "http://github.com/yoshiki/yaml-mode.git"
;;                :features yaml-mode)))

(setq el-get-sources
      '((:name ruby-mode
               :type elpa
               :load "ruby-mode.el"
               :after (lambda () (ruby-mode-hook)))
        (:name inf-ruby  :type elpa)
        (:name ruby-compilation :type elpa)
        (:name css-mode
               :type elpa
               :after (lambda () (css-mode-hook)))
        (:name textmate
               :type git
               :url "git://github.com/defunkt/textmate.el"
               :load "textmate.el")
        (:name rvm
               :type git
               :url "http://github.com/djwhitt/rvm.el.git"
               :load "rvm.el"
               :compile ("rvm.el")
               :after (lambda() (rvm-use-default)))
        (:name rhtml
               :type git
               :url "https://github.com/eschulte/rhtml.git"
               :features rhtml-mode
               :after (lambda () (rhtml-mode-hook)))
        (:name yaml-mode
               :type git
               :url "http://github.com/yoshiki/yaml-mode.git"
               :features yaml-mode
               :after (lambda () (yaml-mode-hook)))))

(el-get 'sync)

;; Line numbers
(global-linum-mode t)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)


(setq scss-compile-at-save nil)


(add-to-list 'load-path "~/.emacs.d/modes/")


(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(autoload 'jsx-mode "jsx-mode" "JSX mode" t)


(add-to-list 'load-path "/some/path/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(ido-mode t)
(ido-vertical-mode t)
