;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Adam Nord"
      user-mail-address "adam.nord04@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;

;;
;; Aesthetics
;;

(setq doom-font (font-spec :family "JetBrains Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "Roboto" :size 13)
      doom-big-font (font-spec :family "JetBrains Mono" :size 24))

(setq doom-theme 'doom-one)

(setq display-line-numbers-type 'relative)

(setq default-frame-alist '((undecorated . t)))
(scroll-bar-mode -1)
;; TODO: treemacs ser ut som en påse skit


(setq scroll-margin 8)
(setq lsp-restart 'ignore)

(global-subword-mode 1)

(setq evil-split-window-below t
      evil-vsplit-window-right t
      evil-want-fine-undo t
      evil-ex-substitute-global t
      evil-kill-on-visual-paste nil)

(setq vterm-kill-buffer-on-exit t)

(after! vterm
  (define-key vterm-mode-map (kbd "<C-backspace>") (lambda () (interactive) (vterm-send-key (kbd "C-w")))))

;; (setq vterm-shell "/bin/zsh")

;; TODO: fixa fucking... indentation
;; (setq standard-indent 2)

;; (setq-default tab-width 2)

;; (setq-default evil-shift-width 2)

;; (setq lisp-indent-offset 2)

;; (add-hook 'lisp-mode-hook
;;   (function (lambda ()
;;               (setq evil-shift-width 2))))
;;
(setq org-directory "~/org/")

(after! lsp-mode
  (setq lsp-eslint-auto-fix-on-save t))

;; (after! lsp-mode
;;   (setq +lsp-company-backends
;;         '(:separate company-capf company-yasnippet company-dabbrev)))

;; TODO: man ska kunna flytta lines

(map! :g "C-s" #'save-buffer)

(map! :after evil :gnvi "C-f" #'consult-line)

(map!
 :after company
 :map company-active-map
 "C-u" #'company-select-previous
 "C-d" #'company-select-next)

(map!
 :after lsp-mode
 :map lsp-mode-map
 :n "K"  #'lsp-ui-doc-glance)

(map!
 :after lsp-mode
 :map lsp-ui-flycheck-list-mode-map
 :n "q"  #'lsp-ui-flycheck-list--quit
 :n "<escape>"  #'lsp-ui-flycheck-list--quit)

(map!
 :after lsp-mode
 :map lsp-mode-map
 :leader
 :prefix "l"
 "e"  #'lsp-ui-flycheck-list)

(map!
 :after vertico
 :map vertico-map
 "C-d"  #'vertico-next
 "C-u"  #'vertico-previous)

(map!
 :n "gn"  #'next-error
 :n "gN"  #'previous-error)

(map!
 :leader
 :prefix "TAB"
 "x"  #'doom/kill-other-buffers
 "X"  #'doom/kill-all-buffers)

;; TODO: prisma, tailwind, vue

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
