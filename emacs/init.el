;; Much of this is from http://viget.com/extend/emacs-24-rails-development-environment-from-scratch-to-productive-in-5-minu

(setq warning-minimum-level :emergency)

(push "/usr/local/bin" exec-path)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq-default tab-width 2)
(setq js-indent-level 2)
(setq typescript-indent-level 2)
(setq nginx-indent-level 2)
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

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;;(setq package-list '(ruby-mode rjsx-mode ido-mode ido-vertical-mode))
(setq package-list '(ruby-mode rjsx-mode neotree ag ivy yaml-mode))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'package)

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


(global-linum-mode)

(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)


(setq scss-compile-at-save nil)


(add-to-list 'load-path "~/.emacs.d/modes/")


;; (add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
;; (autoload 'jsx-mode "jsx-mode" "JSX mode" t)


(add-to-list 'auto-mode-alist '("\\.jsx\\'" . rjsx-mode))
(autoload 'rjsx-mode "rjsx-mode" "JSX mode" t)

;; (add-to-list 'load-path "/some/path/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(add-hook 'before-save-hook 'whitespace-cleanup)

;;(ido-mode t)
;;(ido-vertical-mode t)

(add-to-list 'auto-mode-alist '("\\.cjsx" . coffee-mode))

(menu-bar-mode -1)

(define-globalized-minor-mode global-hs-minor-mode
  hs-minor-mode hs-minor-mode)

; (global-hs-minor-mode 1)

(eval-after-load "hideshow"
  '(add-to-list 'hs-special-modes-alist
    `(ruby-mode
      ,(rx (or "def" "class" "module" "do" "{" "[")) ; Block start
      ,(rx (or "}" "]" "end"))                       ; Block end
      ,(rx (or "#" "=begin"))                        ; Comment start
      ruby-forward-sexp nil)))

(global-set-key (kbd "C-c h") 'hs-hide-block)
(global-set-key (kbd "C-c s") 'hs-show-block)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (yaml-mode rjsx-mode neotree ivy ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
