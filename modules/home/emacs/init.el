(setq inhibit-startup-message t)
(scroll-bar-mode -1)      ; Disable visible scrollbar
(tool-bar-mode -1)        ; Disable the toolbar
(tooltip-mode -1)         ; Disable tooltips
(set-fringe-mode 10)      ; Increase fringes

(menu-bar-mode -1)        ; Disable menu bar
(setq visible-bell t)     ; Enable visible bell

(set-face-attribute 'default nil :font "SF Mono" :weight 'Regular :height 168) ; Set font

(set-fontset-font t nil (font-spec :height 128 :name "Noto Sans Symbols"))

(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "SF Pro Display" :weight normal :height 168)))))

;; Initialise package source
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))

(package-initialize)
(unless package-archive-contents)
  (package-refresh-contents)

;; Initialise use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package ivy
  :diminish
  :config
  (ivy-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-switch-buffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package all-the-icons)

(use-package autothemer)

(setq custom--inhibit-theme-enable nil) ;; Allow themes to be applied

(use-package gruvbox-theme)

(use-package which-key
  :diminish
  :config
  (which-key-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  (setq lsp-enable-snippet nil)
  :hook
  '((lsp-mode . lsp-enable-which-key-integration)
    ((html-mode) . lsp-mode)
    ((go-mode) . lsp-mode)
    ((powershell-mode) . lsp-mode)))

(column-number-mode)
(global-display-line-numbers-mode t)

(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook
		vterm-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable t))

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(defun rune/evil-hook ()
  (dolist (mode '(custom-mode
		  eshell-mode
		  git-rebase-mode
		  erc-mode
		  circe-server-mode
		  circe-chat-mode
		  circe-query-mode
		  sauron-mode
		  term-mode
		  ;;keepass-mode
		  ))
    (add-to-list 'evil-emacs-state-modes mode)))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :hook (evil-mode . rune/evil-hook)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(evil-mode 1)

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Development")
    (setq projectile-project-search-path '("~/Development")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package magit)

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Set up SSH key agent for use with magit
(use-package exec-path-from-shell
  :config
  (setq exec-path-from-shell-variables '("SSH_AGENT_PID" "SSH_AUTH_SOCK" "WAYLAND_DISPLAY"))
  :hook (vterm-mode . exec-path-from-shell-initialize))

(use-package vterm)

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(defun tlc/dired-init ()
  "Function to run when dired is started."
  (dired-hide-details-mode 1))

(add-hook 'dired-mode-hook 'tlc/dired-init)

;;(use-package keepass-mode)

(global-set-key (kbd "C-c t") 'vterm)
(global-set-key (kbd "C-c m") 'mu4e)

;; set default shell to bash for all ssh connections
(add-to-list 'tramp-connection-properties
	     (list (regexp-quote "/ssh")
		   "remote-shell" "/bin/bash"))

(setq tramp-shell-prompt-pattern "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*")

(require 'org-faces)

(defun tlc/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1)
  (setq evil-auto-indent nil))

(defun tlc/org-font-setup ()
  (dolist (face '((org-level-1 . 1.2)
		  (org-level-2 . 1.1)
		  (org-level-3 . 1.05)
		  (org-level-4 . 1.0)
		  (org-level-5 . 1.1)
		  (org-level-6 . 1.1)
		  (org-level-7 . 1.1)
		  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "SF Pro Display" :weight 'Regular :height (cdr face)))

  ;; Replace list hyphen with bullet point
  (font-lock-add-keywords 'org-mode
			  '(("^ *\\([-]\\) "
			     (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(use-package org
  :hook (org-mode . tlc/org-mode-setup)
  :config
  (tlc/org-font-setup)
  (advice-add 'org-refile :after 'org-save-all-org-buffers)
  (custom-theme-set-faces
   'user
   '(fixed-pitch ((t ( :family "SF Mono" :height 128)))))
  :custom
  (org-export-with-author nil)
  (org-ellipsis " ")
  (org-hide-emphasis-markers t)

  (org-agenda-files '("~/OrgFiles/Tasks.org"))

  (org-capture-templates
   '(("t" "Todo" entry (file+headline "~/OrgFiles/Tasks.org" "Active")
      (file "~/RoamNotes/Templates/Todo.org"))
     ("m" "Email Workflow")
       ("mf" "Follow Up" entry (file+olp "~/OrgFiles/Tasks.org" "Active")
	  "* TODO %a\n  %i")))
  
  (org-directory "~/OrgFiles")

  (org-agenda-start-with-log-mode nil)
  (org-log-done 'time)
  (org-log-into-drawer t)
  (org-refile-targets
   '(("~/OrgFiles/Archive.org" :maxlevel . 1)
     ("~/OrgFiles/Tasks.org" :maxlevel . 1)))
  (org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))))

(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package org-roam
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/RoamNotes")
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("c" "Change Request" plain
      (file "~/RoamNotes/Templates/ChangeRequest.org")
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)))
  (org-roam-dailies-capture-templates
   '(("d" "default" entry "* %<%k:%M> - %?"
      :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert)
	 :map org-mode-map
	 ("C-M-i" . completion-at-point)
	 :map org-roam-dailies-map
	 ("Y" . org-roam-dailies-capture-yesterday)
	 ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies) ;; Ensuire the keymap is available
  (org-roam-db-autosync-enable))

(defun tlc/org-mode-visual-fill ()
  (setq visual-fill-column-width 125
	visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . tlc/org-mode-visual-fill))

(use-package highlight-indent-guides
  :hook ((prog-mode . highlight-indent-guides-mode)
	 (yaml-mode . highlight-indent-guides-mode))
  :init (highlight-indent-guides-auto-set-faces))

(use-package flycheck
  :init (global-flycheck-mode))

(use-package ob-powershell)

(use-package powershell)

(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
  (add-hook 'yaml-mode-hook #'(lambda () (ansible 1)))
  (add-hook 'yaml-mode-hook 'lsp-deferred))

(org-babel-do-load-languages
 'org-babel-load-languages
 (quote (
	 (powershell . t)
	 (shell . t))))

(use-package company)

(use-package systemd)

(use-package company-go)

(use-package go-mode
  :defer t
  :config
  (add-hook 'go-mode-hook 'lsp-deferred)
  (add-hook 'go-mode-hook
	    (lambda ()
	      (add-hook 'before-save-hook 'ime-go-before-save)))
  (require 'lsp-go)
  (require 'lsp-pyls)
  :custom
  (lsp-go-gopls-server-path "~/go/bin/gopls"))

(setq backup-directory-alist '(("." . "~/.local/cache/emacs/backup"))
;  backup-by-copying t    ; Don't delink hardlinks
;  version-control t      ; Use version numbers on backups
;  delete-old-versions t  ; Automatically delete excess backups
;  kept-new-versions 20   ; how many of the newest versions to keep
;  kept-old-versions 5    ; and how many of the old
      )

(use-package treemacs)

(customize-set-variable
 'tramp-password-prompt-regexp
 (concat
  "^.*"
  (regexp-opt
   '("Verification code" "Password"
     "passphrase" "Passphrase")
   t)
  ".*:\0? *"))

(use-package vlf)

(use-package restclient)

(use-package company-restclient)

(use-package jinja2-mode)

(use-package ansible)

(use-package company-ansible)

(use-package lsp-treemacs)

(use-package csv-mode)

(use-package ox-reveal
  :custom
  org-reveal-root "file:///home/user/Development/reveal.js-4.5.0")

(use-package ox-pandoc
  :after org
  :init (add-to-list 'org-export-backends 'pandoc))

(defun ikl-mu4e-refile-folder (msg)
  "Function for choosing the refile folder
   MSG is a message p-list from mu4e."
  (cond
   ;; BMS messages
   ((mu4e-message-contact-field-matches msg :from
					"support@italik.co.uk")
    "/LocalArchive/BMS")
   (t "/LocalArchive/Inbox")))

(use-package mu4e
  :ensure nil
  :custom
  (mu4e-sent-messages-behavior 'delete)
  :config
  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  ;; Refresh mail using isync every minute
  (setq mu4e-update-interval (* 1 60))
  (setq mu4e-get-mail-command "mbsync -c ~/.config/mbsync/mbsyncrc -aqq")
  (setq mu4e-maildir "~/Mail/Work")

  (setq user-mail-address "ben.standerline@italik.co.uk")

  (setq mu4e-drafts-folder "/Drafts")
  (setq mu4e-sent-folder "/Sent")
  (setq mu4e-trash-folder "/LocalArchive/Trash")
  (setq mu4e-refile-folder 'ikl-mu4e-refile-folder)

  (setq smtpmail-smtp-server "localhost"
	smtpmail-smtp-service 1025
	smtpmail-stream-type 'plain
	smtpmail-smtp-user "ben.standerline@italik.co.uk")

  (setq mu4e-compose-format-flowed t)

  (setq mu4e-compose-signature
	(concat
	 "Ben Standerline\n"
	 "Italik Ltd | Technical Specialist\n"
	 "E: ben.standerline@italik.co.uk\n"
	 "T: 01937 848 380"))

  (setq message-send-mail-function 'smtpmail-send-it)

  (setq mu4e-maildir-shortcuts
	'(("/Inbox"              . ?i)
	  ("/Sent"               . ?s)
	  ("/LocalArchive/Trash" . ?t)
	  ("/Drafts"             . ?d)
	  ("/LocalArchive/Inbox" . ?a)))

  (mu4e t))

(use-package mu4e-org
  :ensure nil)

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package php-mode)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fixed-pitch ((t (:family "SF Mono" :height 128))))
 '(variable-pitch ((t (:family "SF Pro Display" :weight normal :height 168)))))
(put 'dired-find-alternate-file 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(org-mime lsp-treemacs company-ansible ansible jinja2-mode yasnippet yaml-mode which-key vterm vlf visual-fill-column use-package treemacs systemd rainbow-delimiters projectile powershell ox-reveal ox-pandoc org-roam org-re-reveal org-bullets ob-powershell magit lsp-ui ivy-rich highlight-indent-guides helpful gruvbox-theme flycheck exec-path-from-shell evil-collection doom-modeline csv-mode counsel company-restclient company-go all-the-icons-dired)))

