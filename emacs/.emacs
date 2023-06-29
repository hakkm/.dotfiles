;;   ________              __      __         .__   .__    
;;  /  _____/   ____      /  \    /  \  ____  |  |  |  |   
;; /   \  ___  /  _ \     \   \/\/   /_/ __ \ |  |  |  |   
;; \    \_\  \(  <_> )     \        / \  ___/ |  |__|  |__ 
;;  \______  / \____/       \__/\  /   \___  >|____/|____/ 
;;how to   \/                    \/        \/              
;;  ___________            ________             ___________                  __    
;; \__    ___/____       /  _____/   ____      \_   _____/_____     _______/  |_  
;;   |    |  /  _ \     /   \  ___  /  _ \      |    __)  \__  \   /  ___/\   __\ 
;;   |    | (  <_> )    \    \_\  \(  <_> )     |     \    / __ \_ \___ \  |  |   
;;   |____|  \____/      \______  / \____/      \___  /   (____  //____  > |__|   
;;                              \/                  \/         \/      \/         



(setq inhibit-startup-message t)      ;; start with plan text
(scroll-bar-mode -1)                  ;; disable visible scroll bar
(tool-bar-mode -1)                    ;; disable toolbar that includes icons
;;(menu-bar-mode -1)                    ;; disable menu var includes file edit view so on
(set-fringe-mode 10)                  ;; ar:lhamix, 
;;               **                   ;; width of the fringe
(tooltip-mode 1)                     ;; Tooltips are small special frames that display text 
                                      ;; information at the current mouse position(hover)
(setq visible-bell t)               
(column-number-mode)                  ;; add column number in line mode
(global-display-line-numbers-mode t)
(setq display-line-numbers 'relative)

;; Make ESC quit prompts
;;(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(custom-safe-themes
	 '("251ed7ecd97af314cd77b07359a09da12dcd97be35e3ab761d4a92d8d8cf9a71" default))
 '(org-tags-column -80)
 '(package-selected-packages
	 '(smex ivysmex ivy-smex mpv evil-nerd-commenter org-babbel all-the-icons python-mode lsp-ui lsp-ivy lsp-pyright lsp-mode lsp visual-fill-column org-bullets evil-magit magit counsel-projectile projectile hydra evil-collection keychord key-chord evil general doom-themes helpful ivy-rich which-key rainbow-delimiters nerd-icons-dired ivy use-package)))

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
 												("org" . "https://orgmode.org/elpa/")
  												("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-next-line)
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

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package nerd-icons)
(use-package nerd-icons-dired)
(use-package all-the-icons)


(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (;;("M-x" . 'counsel-M-x)
	 ("C-M-j" . 'counsel-switch-buffer))
         ;; :map minibuffer-local-map
         ;; ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

(use-package helpful
  :ensure t
  :custom
  (Counsel-Describe-Function-Function #'Helpful-Callable)
  (Counsel-Describe-Variable-Function #'Helpful-Variable)
  :bind
  ([Remap Describe-Function] . Helpful-Callable)
  ([Remap Describe-Command] . Helpful-Command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package doom-themes
  :init (load-theme 'doom-monokai-classic t))

(global-set-key (kbd "C-h v") 'helpful-variable)
(global-set-key (kbd "C-h f") 'helpful-function)

(use-package general
  :after evil
  :config
  (general-create-definer ahk/leader-keys
    :keymaps  '(normal insert visual emacs)
    :prefix "SPC"	
    :global-prefix "C-SPC")							

  (ahk/leader-keys
    "t"  '(:ignore t  :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")
		"ts" '(hydra-text-scale/body :which-key "scale text")
		"p"  '(projectile-command-map :which-key "projectile")
		"c"  '(:ignore t :which-key "commenting")		 
		"cd" '(comment-dwim :which-key "document")
		"m" '(mpv-insert-playback-position :which-key "mpv playback"))) 



(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump t)
  :config
	(evil-mode 1)
	;;Exit insert mode by pressing j and then j quickly
;;	(setq key-chord-two-keys-delay 0.1)
;;	(key-chord-define evil-insert-state-map "kj" 'evil-force-normal-state)
;;	(key-chord-mode 1)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

	
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(evil-define-key '(normal visual) 'global (kbd "<escape>") 'keyboard-escape-quit)
(evil-define-key '(normal visual) 'global (kbd "gcc") 'comment-line)

;; tab width custom
(setq-default tab-width 2)
(setq-default c-basic-offset 2)
(setq-default evil-shift-width 2)

(use-package evil-collection
	:after evil ;; after evil loads
	:config
	(evil-collection-init))


;; kj switch to normal mode
(defun my-evil-normal-after-k (key)
  (interactive "c")
  (if (and (eq last-command-event ?k)
           (eq key ?j))
      (evil-normal-state)
    (insert-char last-command-event)
    (insert-char key)))

(define-key evil-insert-state-map "k" 'my-evil-normal-after-k)
;; end

(use-package hydra)
(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))


(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/pr/python/projects")
    (setq projectile-project-search-path '("~/pr/python/projects")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
	:config (counsel-projectile-mode))

(use-package magit
	:custom
	(magit-diepslay-buffer-function #'magit-dispaly-buffer-smae-window-except-diff-v1))

;;(use-package evil-magit
;;	:after magit)

(defun ahk/org-mode-setup()
  (auto-fill-mode t)
  (set-fill-column 90)
	(org-indent-mode)
	(variable-pitch-mode 0)
	(visual-line-mode 1)
	(setq evil-auto-indent nil))


(use-package org
  :hook (org-mode . ahk/org-mode-setup)
  :config
	(setq org-agenda-files
				'("~/t/todos.org" "~/emacs-config-notes.org"))
  (setq org-ellipsis " ▾"  
				org-hide-emphasis-markers t)
  (setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
      (sequence "QUESTION(q)" "GUESS(g)" "|" "ANSWERED(s!)")
      (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)"))))

  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
   '(("d" "Dashboard"
     ((agenda "" ((org-deadline-warning-days 7)))
      (todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))
      (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

    ("n" "Next Tasks"
     ((todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))))

    ("W" "Work Tasks" tags-todo "+work-email")

    ;; Low-effort next actions
    ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
     ((org-agenda-overriding-header "Low Effort Tasks")
      (org-agenda-max-todos 20)
      (org-agenda-files org-agenda-files)))

    ("w" "Workflow Status"
     ((todo "WAIT"
            ((org-agenda-overriding-header "Waiting on External")
             (org-agenda-files org-agenda-files)))
      (todo "REVIEW"
            ((org-agenda-overriding-header "In Review")
             (org-agenda-files org-agenda-files)))
      (todo "PLAN"
            ((org-agenda-overriding-header "In Planning")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "BACKLOG"
            ((org-agenda-overriding-header "Project Backlog")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "READY"
            ((org-agenda-overriding-header "Ready for Work")
             (org-agenda-files org-agenda-files)))
      (todo "ACTIVE"
            ((org-agenda-overriding-header "Active Projects")
             (org-agenda-files org-agenda-files)))
      (todo "COMPLETED"
            ((org-agenda-overriding-header "Completed Projects")
             (org-agenda-files org-agenda-files)))
      (todo "CANC"
            ((org-agenda-overriding-header "Cancelled Projects")
             (org-agenda-files org-agenda-files)))))))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))


  ;; Replace list hyphen with dot
(font-lock-add-keywords 'org-mode
												'(("^ *\\([-]\\) "
														(0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(defun my/org-mode-hook ()
  "Stop the org-level headers from increasing in height relative to the other text."
(set-face-attribute 'org-level-1 nil :weight 'semi-bold :height 1.5 :family "Ubuntu Medium")
(set-face-attribute 'org-level-2 nil :weight 'semi-bold :height 1.4 :family "Ubuntu Medium")
(set-face-attribute 'org-level-3 nil :weight 'semi-bold :height 1.3 :family "Ubuntu Medium")
(set-face-attribute 'org-level-4 nil :weight 'semi-bold :height 1.2 :family "Ubuntu Medium")
(set-face-attribute 'org-level-5 nil :weight 'semi-bold :height 1.1 :family "Ubuntu Medium")
(set-face-attribute 'org-level-6 nil :weight 'semi-bold :height 1.0 :family "Ubuntu Medium")
(set-face-attribute 'org-level-7 nil :weight 'semi-bold :height 1.0 :family "Ubuntu Medium")
(set-face-attribute 'org-level-8 nil :weight 'semi-bold :height 1.0 :family "Ubuntu Medium"))


(add-hook 'org-mode-hook #'my/org-mode-hook)

(defun hakim/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
   :hook (org-mode . hakim/org-mode-visual-fill))


;; Disable line numbers for some modes
(defun remove-line-numbers()
  "Disable line numbers."
  (display-line-numbers-mode -1))

(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook		
                eshell-mode-hook
								custom-mode-hook
								emacs-lisp-mode-hook
								helpful-mode-hook
								help-mode-hook))
	(add-hook mode 'remove-line-numbers)) 
;; end disable line numbers

(use-package lsp-mode
	:commands (lsp lsp-defrred)
  :init
  (setq lsp-keymap-prefix "C-c l")
	:config
	(lsp-enable-which-key-integration t))

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-ui :commands lsp-ui-mode)
(use-package python-mode
	:ensure t
	:custom
	(python-shell-interpreter "python3"))


    (org-babel-do-load-languages
        'org-babel-load-languages
        '((emacs-lisp . t)
        (python . t)))

    (push '("conf-unix" . conf-unix) org-src-lang-modes)

(setq org-config-babel-evaluate nil)

  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
	(add-to-list 'org-structure-template-alist '("q" . "quote"))

(set-face-attribute 'default nil :family "monospace" :height 130)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun ahk/evil-normal-after-k (key)
  (interactive "c")
  (if (and (eq last-command-event ?k)
           (eq key ?j))
      (progn
        (run-with-timer 0.3 nil 'keyboard-quit)
        (evil-normal-state))
    (insert-char last-command-event)
    (insert-char key)))

(define-key evil-insert-state-map "k" 'ahk/evil-normal-after-k)



(use-package mpv)
(use-package flyspell)
(dolist (hook '(text-mode-hook
								org-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))


(use-package smex)
(add-hook 'focus-in-hook 
  (lambda () (progn 
    (setq org-tags-column (- 10 (window-body-width)))) (org-align-all-tags)))

(add-hook 'focus-out-hook 
  (lambda () (progn 
    (setq org-tags-column (- 10 (window-body-width)))) (org-align-all-tags)))
