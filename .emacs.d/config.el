(setq inhibit-startup-message t) ;; Disable Message

(scroll-bar-mode -1) ;;Disable visible scrollbar

(menu-bar-mode -1) ;;Disable the menu bar

(setq visible-bell -1) ;;Set up the visible bell

(show-paren-mode 1) ;; Enable ShowParent

(tool-bar-mode -1) ;;Disable the toolbar

(tooltip-mode -1) ;;Disable tooltips

(column-number-mode) ;;:Enable number
(global-display-line-numbers-mode t)

(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq browse-url-generic-program 
      (executable-find "firefox-bin")
      browse-url-browser-function 'browse-url-generic)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;;(set-face-attribute 'default nil :font "Fira Code Retina" :height 101)

;; Set the fixed pitch face
;;(set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height 101)

;; Set the variable pitch face
;;(set-face-attribute 'variable-pitch nil :font "Cantarell" :height 101 :weight 'regular)

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)    
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

(use-package doom-themes
    :init
    (load-theme 'doom-nord t))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 15))

(use-package all-the-icons)

(use-package all-the-icons-ivy-rich
  :defer 1
  :config(all-the-icons-ivy-rich-mode 1))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(defun dw/org-mode-setup ()
  (org-indent-mode)
  ;; (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil))

(use-package org
  :hook (org-mode . dw/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
        org-hide-emphasis-markers t))


(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-remove-leading-stars t)
  (org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")))



(with-eval-after-load 'org-faces
  (set-face-attribute 'org-document-title nil :font "Cantarell" :weight 'bold :height 1.3)
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))


  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch))


(defun dw/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . dw/org-mode-visual-fill))

(use-package ivy
  :defer 5
  :diminish ivy-mode
  :bind(("C-s" . swiper)
        :map ivy-minibuffer-map
        ("TAB" . ivy-alt-done)
        ("C-f" . ivy-alt-done)
        ("C-l" . ivy-alt-done)
        ("C-j" . ivy-next-line)
        ("C-k" . ivy-previous-line)
        :map ivy-switch-buffer-map
        ("C-k" . ivy-previous-line)
        ("C-l" . ivy-done)
        ("C-d" . ivy-switch-buffer-kill)
        :map ivy-reverse-i-search-map
        ("C-k" . ivy-previous-line)
        ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package which-key ;;
  :defer 5
  :diminish which-key-mode
  :config (which-key-mode
           (setq which-key-idle-delay 2)))

(use-package ivy-rich
  :defer 7
  :config
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^

(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (progn
    (setq web-mode-engines-alist
          '(("django"  . "\\.html\\'")))
    (setq web-mode-ac-sources-alist
          '(("css" . (ac-source-css-property))
            ("html" . (ac-source-work-in-buffer ac-source-abbrev))))
    (setq web-mode-enable-auto-closing t)
    (setq web-mode-enable-auto-quoting t)
    (setq web-mode-enable-current-column-highlight t)
    (setq web-mode-enable-current-element-highlight t)))

(use-package emmet-mode
  :defer 5
  :hook
  (sgml-mode . emmet-mode) ;; Auto-start on any markup modes
  (web-mode . emmet-mode) ;; Auto-start on any markup modes
  (css-mode . emmet-mode)) ;; enable Emmet's css abbreviation.

(use-package company
  :defer 5
  :hook
  (after-init . global-company-mode))

(use-package skewer-mode
  :defer 5
  :hook
  (css-mode .skewer-css-mode)
  (html-mode . skewer-html-mode))

(use-package simple-httpd
  :defer t)

(use-package rjsx-mode
	  :mode "\\.js\\'")

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))
(setq company-tooltip-align-annotations t)
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)

(use-package tide 
  :defer 5
  :after (rjsx-mode company flycheck)
  :hook (rjsx-mode . setup-tide-mode))

(use-package prettier-js
  :defer 5
  :after (rjsx-mode)
  :hook (rjsx-mode . prettier-js-mode))

(use-package flycheck
  :defer 5
  :config
  (global-flycheck-mode))
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :demand t
  :bind ("C-M-p" . projectile-find-file)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Projects/Code")
    (setq projectile-project-search-path '("~/Projects/Code")))
  (setq projectile-switch-project-action #'projectile-dired))

(defun dw/after-tracking-remove-buffer (buffer)
  (dw/update-polybar-telegram))

(advice-add 'tracking-add-buffer :around #'dw/around-tracking-add-buffer)
(advice-add 'tracking-remove-buffer :after #'dw/after-tracking-remove-buffer)
(advice-remove 'tracking-remove-buffer #'dw/around-tracking-remove-buffer)

;; Advise exwm-workspace-switch so that we can more reliably clear tracking buffers
;; NOTE: This is a hack and I hate it.  It'd be great to find a better solution.
(defun dw/before-exwm-workspace-switch (frame-or-index &optional force)
  (when (fboundp 'tracking-remove-visible-buffers)
    (when (eq exwm-workspace-current-index 0)
      (tracking-remove-visible-buffers))))

(advice-add 'exwm-workspace-switch :before #'dw/before-exwm-workspace-switch)

(use-package telega
  :commands telega
  :config
  (setq telega-user-use-avatars nil
        telega-use-tracking-for '(any pin unread)
        telega-chat-use-markdown-formatting t
        telega-emoji-use-images t
        telega-completing-read-function #'ivy-completing-read
        telega-msg-rainbow-title nil
        telega-chat-fill-column 75))

(use-package dashboard
  :ensure t
  :init
  (progn
    (setq dashboard-items '((projects . 5) 
                            (recents . 10))) 
    (setq dashboard-show-shortcuts nil)
    (setq dashboard-center-content nil)
     ;;(setq dashboard-banner-logo-title "Lindo, siono raza?")
    (setq dashboard-set-file-icons t)
    (setq dashboard-set-heading-icons t)
    ;;(setq dashboard-startup-banner "~/.emacs.d/logo/logo.png")
    (setq dashboard-set-navigator t)
    )
  :config
  (dashboard-setup-startup-hook))

(setq dashboard-navigator-buttons
      `(;; line1
        ((,(all-the-icons-octicon "mark-github" :height 1.1 :v-adjust 0.0)
          "Homepage"
          "Browse homepage"
          (lambda (&rest _) (browse-url "https://github.com/a-bbi")))
         ("★" nil "Show stars" (lambda (&rest _) (show-stars)) warning))
        ;; line 2
        ;; ((,(all-the-icons-faicon "linkedin" :height 1.1 :v-adjust 0.0)
        ;;   "Linkedin"
        ;;   ""
        ;;   (lambda (&rest _) (browse-url "homepage")))
        ;;  ("⚑" nil "Show flags" (lambda (&rest _) (message "flag")) error))
        ))

(use-package ace-window
  :bind
  ("C-x o" . ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f)))

(use-package rainbow-delimiters
  :defer 5
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package command-log-mode
  :defer t)

(use-package helpful
  :defer 5
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . helpful-function)
  ([remap describe-symbol] . helpful-symbol)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))
