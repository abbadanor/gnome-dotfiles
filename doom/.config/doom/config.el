;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq default-frame-alist '((undecorated . t)))

(setq user-full-name "Adam Nord"
      user-mail-address "adam.nord04@gmail.com")

(setq doom-font (font-spec :family "JetBrains Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 13)
      doom-big-font (font-spec :family "Iosevka Aile" :size 24))

(load-theme 'doom-palenight 't)

(map! :leader
  :desc "Eval line or region" "e" #'+eval/line-or-region)

(map!
  :nv "C-s" #'save-buffer
  :nv "C-f" #'consult-line
  :g "C-TAB" #'centaur-tabs-forward-tab
  :g "C-S-TAB" #'centaur-tabs-forward-tab
  )

(setq display-line-numbers-type 'relative)

(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq scroll-margin 6)

(after! drag-stuff
  (drag-stuff-mode t))

(defun an/evil-shift-right ()
  (interactive)
  (evil-shift-right evil-visual-beginning evil-visual-end)
  (evil-normal-state)
  (evil-visual-restore))

(defun an/evil-shift-left ()
  (interactive)
  (evil-shift-left evil-visual-beginning evil-visual-end)
  (evil-normal-state)
  (evil-visual-restore))

(after! evil
  (setq evil-kill-on-visual-paste nil))

(map!
 :i "C-g"  #'evil-normal-state
 :v "<" #'an/evil-shift-left
 :v ">" #'an/evil-shift-right
 :v "J" #'drag-stuff-down
 :v "K" #'drag-stuff-up
 :m "C-f" nil)

(defun an/evil-yank-advice (orig-fn beg end &rest args)
  (pulse-momentary-highlight-region beg end)
  (apply orig-fn beg end args))

(advice-add 'evil-yank :around #'an/evil-yank-advice)

(setq-default tab-width 2)
(setq-default evil-shift-width tab-width)
(setq-default indent-tabs-mode nil)

(defun an/org-mode-visual-fill ()
  (setq visual-fill-column-width 110
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package! visual-fill-column
  :defer t
  :hook (org-mode . an/org-mode-visual-fill))

(setq even-window-sizes nil)

(setq org-directory "~/org/")
(setq org-roam-directory "~/org/roam/")

(use-package! svg-tag-mode
  :after org
  :hook (org-mode . svg-tag-mode)
  :config
  (setq svg-tag-tags
        '(("TODO" . ((lambda (tag) (svg-tag-make "TODO"))))
          ("DONE" . ((lambda (tag) (svg-tag-make "DONE"))))
          ("\\(:#[A-Za-z0-9]+\\)" . ((lambda (tag) (svg-tag-make tag :beg 2))))
          ("\\(:#[A-Za-z0-9]+:\\)$" . ((lambda (tag) (svg-tag-make tag :beg 2 :end -1))))
          )))
