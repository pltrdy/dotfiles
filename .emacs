;;Adding local directory for mods
(add-to-list 'load-path"~/.emacs.d/")
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/irony-mode-develop/elisp/"))

;;Coloration syntaxique
(show-paren-mode t)
(set-background-color "#242424")
(set-foreground-color "#f6f3e8")
(set-cursor-color "#656565")
(set-face-foreground 'font-lock-comment-face "#99968b")
(set-face-italic-p 'font-lock-comment-face t)
(set-face-foreground 'font-lock-doc-face "#99968b")
(set-face-italic-p 'font-lock-doc-face t)
(set-face-foreground 'font-lock-constant-face "#e5786d")
(set-face-foreground 'font-lock-string-face "#95e454")
(set-face-italic-p 'font-lock-string-face t)
(set-face-foreground 'font-lock-variable-name-face "#cae682")
(set-face-foreground 'font-lock-function-name-face "#cae682")
(set-face-foreground 'font-lock-type-face "#cae682")
(set-face-foreground 'font-lock-builtin-face "#8ac6f2")
(set-face-foreground 'font-lock-keyword-face "#8ac6f2")
(set-face-foreground 'font-lock-preprocessor-face "#e5786d")
(set-face-foreground 'font-lock-negation-char-face "#e7f6da")
(set-face-foreground 'link "#8ac6f2")
(set-face-bold-p 'link t)
(set-face-underline-p 'link t)
(set-face-foreground 'show-paren-match "#f6f3e8")
(set-face-background 'show-paren-match "#857b6f")
(set-face-bold-p 'show-paren-match t)
(set-face-foreground 'region "#f6f3e8")
(set-face-background 'region "#444444")
(set-face-foreground 'lazy-highlight "black")
(set-face-background 'lazy-highlight "yellow")
(set-face-foreground 'minibuffer-prompt "#6eadff")
;; >> AFFICHAGE
;; titre de la fenêtre = nom du buffer courant
(setq frame-title-format "%b - emacs")

;;supporting colors correctly
(defun terminal-init-screen()
  "Terminal initialization function for screen."
  (xterm-register-default-colors)
  (tty-set-up-initial-frame-faces))

;; pas de fichiers #*#
(setq make-backup-files nil)
(setq vc-make-backup-files nil)
(setq auto-save-default nil)
(setq delete-auto-save-files t)

;; Tiger Mode
(autoload 'tiger-mode "tiger" "Load tiger-mode" t)
(add-to-list 'auto-mode-alist '("\\.ti[gh]$" . tiger-mode))

;;C# Mode
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))

;;auto-complete mode
;;(require 'auto-complete)
;;(require 'irony)

;; the ac plugin will be activated in each buffer using irony-mode
;;(irony-enable 'ac)             ; hit C-RET to trigger completion

(defun my-c++-hooks ()
  "Enable the hooks in the preferred order: 'yas -> auto-complete -> irony'."
  ;; if yas is not set before (auto-complete-mode 1), overlays may persist after
  ;; an expansion.
  ;;(auto-complete-mode 1)
  ;;(irony-mode 1))
)
(add-hook 'c++-mode-hook 'my-c++-hooks)
(add-hook 'c-mode-hook 'my-c++-hooks)

;;(load "custom-cmake") ; cmake autoload

(defun my-csharp-mode-fn ()
  "function that runs when csharp-mode is initialized for a buffer."
  (turn-on-auto-revert-mode)
  (setq indent-tabs-mode nil)
  (require 'flymake)
  (flymake-mode 1)
  (require 'yasnippet)
  (yas/minor-mode-on)
  (require 'rfringe)
  )
(add-hook  'csharp-mode-hook 'my-csharp-mode-fn t)

;;numéros de ligne
(require 'linum)
(global-linum-mode)
(setq linum-format "%d ")

;;Caracteres max par ligne
(setq-default auto-fill-function 'do-auto-fill)
(setq-default fill-column 80)
;; affichage de la barre d'état :
;; ... affiche le numéro de la ligne et de la colonne courante
(line-number-mode t)
(setq column-number-mode t)
;; ... ainsi que l'heure et la date du jour
(setq display-time-string-forms
'(24-hours ":" minutes " - " dayname " " day "/" month"/"year " " ))
(display-time)

;;bracket alignment for epita's coding style (if, while, for, ...)
(c-set-offset 'substatement-open '0)
(c-set-offset 'brace-list-open '0)
(c-set-offset 'statement-case-open '0)

;; Better gdb
(setq-default gdb-many-windows t)

;; >> CONFORT D'UTILISATION
;; remplacer le 'yes' par 'y' et 'no' par 'n'
(fset 'yes-or-no-p 'y-or-n-p)
;; complète automatiquement ce que vous tapez dans le mini-buffer
(icomplete-mode 1)
;; sélection avec shift
;;(pc-selection-mode)
;; ne pas bouger le pointeur lorsqu'on fait un yank avec la molette
(setq mouse-yank-at-point nil)

;;JEAN
;;Deplacement entre les fenetres
(windmove-default-keybindings 'meta)

;; commande de compilation par défaut (remplace make -k)
;; soit par 'make' soit par 'gcc -Wall toto.c -o toto'
(setq compile-command "make")
(setq compilation-window-heigh 8)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; append-tuareg.el - Tuareg quick installation: Append this file to .emacs.

(setq auto-mode-alist (cons '("\\.ml\\w?" . tuareg-mode) auto-mode-alist))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)


;; Configuration  de tuareg
(add-hook 'tuareg-mode-hook
          '(lambda ()
             (auto-fill-mode 1)
;; turn on auto-fill minor mode
;; (passage a la ligne automatique)
             (define-key tuareg-mode-map [f4] 'goto-line)
             (define-key tuareg-mode-map [f5] 'compile)
             (define-key tuareg-mode-map [f6] 'recompile)
             (define-key tuareg-mode-map [f7] 'next-error)
;; quelques raccourcis
             (setq tuareg-sym-lock-keywords nil)
;; ne pas remplacer les mots cles par des symboles
             ))

;; Affichage des colonnes
(setq column-number-mode t)

;; La molette affecte le buffer sous la souris
(setq mouse-wheel-follow-mouse t)


;; Highlight de la region selectionne au clavier
(transient-mark-mode 1)

;; No tabs
(setq-default indent-tabs-mode nil)

;; Pour etre sur de ne pas beeper
(setq visible-bell nil)

;; option pour l'affichage des parentheses
(setq show-paren-face 'modeline)

;; Color and revert
(setq global-font-lock-mode t)

(setq global-auto-revert-mode t)

;;LateX config
;;(load "auctex.el" nil t t)
;;(load "preview-latex.el" nil t t)

(custom-set-faces
'(my-tab-face            ((((class color)) (:background "grey10"))) t)
'(my-trailing-space-face ((((class color)) (:background "gray10"))) t)
'(my-long-line-face ((((class color)) (:background "gray10"))) t))

(add-hook 'font-lock-mode-hook
          (function
           (lambda ()
             (setq font-lock-keywords
                   (append font-lock-keywords
                           '(("\t+" (0 'my-tab-face t))
                             ("^.\\{81,\\}$" (0 'my-long-line-face t))
                             ("[ \t]+$"      (0 'my-trailing-space-face
                                                t))))))))



;;Show spaces at the end of the lines
;;(require 'show-wspace)
;;(add-hook 'font-lock-mode-hook 'show-ws-highlight-trailing-whitespace)
;; Draw tabs with the same color as trailing whitespace
(add-hook 'font-lock-mode-hook
          (lambda ()
            (font-lock-add-keywords
             nil
             '(("\t" 0 'trailing-whitespace prepend)))))

;; Conversion de l'encodage des données lors d'un copier / coller
;; depuis d'autres logiciels sous X.
;; La valeur « compound-text-with-extensions » fait disparaître le
;; problème des conversions de lettres accentuées :
;;   é => ^[%/1\200\214iso8859-15^B
;; Cette fonction n'existe qu'à partir de la version 21 d'Emacs.
;; (if (>= emacs-major-version 21)
;;   (setq selection-coding-system 'compound-text-with-extensions)
;; )

;; Lorsqu'une ligne est plus large que la fenêtre d'affichage, je veux
;; qu'Emacs me l'affiche sur autant de lignes que nécessaire plutôt
;; que de masquer la partie qui dépasse à droite de l'écran. Pour que
;; ce comportement vaille en toute circonstance, il est nécessaire de
;; fixer deux variables.
;; - truncate-lines : comportement dans un tampon occupant toute la
;;   largeur de la fenêtre
;; - truncate-partial-width-windows : comportement dans un tampon
;;   n'occupant qu'une fraction de la largeur de la fenêtre (par
;;   exemple, après un découpage horizontal C-x 3).
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

;; ===================================================================
;; =====   Edition de code C/C++                                 =====
;; ===================================================================

;; Charger le mode C/C++
(require 'cc-mode)


(defconst my-c-style
  '(;; L'appui sur la touche « tabulation » ne doit pas insérer une
    ;; tabulation mais indenter la ligne courante en fonction du
    ;; contexte et des règles définies dans le style.
    (c-tab-always-indent . t)
    ;; L'indentation se fait avec un pas de 2 caractères
    (c-basic-offset . 2)
    ;; Les commentaires qui occupent seuls une ligne sont alignés avec
    ;; le code
    (c-comment-only-line-offset . 0)
    ;; Les commentaires multi-ligne commencent par une simple ligne '/*'
    (c-hanging-comment-starter-p . t)
    ;; et se terminent par une simple ligne '*/'
    (c-hanging-comment-ender-p . t)
    ;; Cas où une accolade est « électrique » (i.e. provoque une mise
    ;; en page automatique)
    (c-hanging-braces-alist .
      ((substatement-open after)
       (brace-list-open)
       (brace-entry-open)
       (block-close . c-snug-do-while)
       (extern-lang-open after)
       (inexpr-class-open after)
       (inexpr-class-close before)))
    ;; Cas où le caractère « : » est « électrique » (i.e. provoque une
    ;; mise en page automatique)
    (c-hanging-colons-alist .
      ((member-init-intro before)
       (inher-intro)
       (case-label after)
       (label after)
       (access-label after)))
    ;; Nettoyage automatique de certaines mises en page
    (c-cleanup-list .
      (scope-operator
       empty-defun-braces
       defun-close-semi))
    (c-offsets-alist .
      (;; Première ligne d'une construction de premier niveau (par
       ;; exemple une déclaration de fonction)
       (topmost-intro . 0)
       ;; Lignes suivantes d'une construction de premier niveau
       (topmost-intro-cont . 0)
       ;; Première ligne d'une liste d'argument
       (arglist-intro . +)
       ;; Argument lorsque la ligne ouvrant la liste ne contient pas
       ;; d'argument.
       (arglist-cont . 0)
       ;; Argument lorsque la ligne ouvrant la liste en contient au moins un.
       (arglist-cont-nonempty . c-lineup-arglist)
       ;; Parenthèse fermant une liste d'arguments mais non précédée d'un
       ;; argument sur la même ligne.
       (arglist-close . c-lineup-close-paren)
       ;; Première ligne d'une instruction quelconque
       (statement . 0)
       ;; Lignes suivantes de l'instruction quelconque
       (statement-cont . +)
       ;; Première ligne d'un bloc
       (statement-block-intro . +)
       ;; Première ligne d'un bloc case
       (statement-case-intro . +)
       ;; Première ligne d'un bloc case commençant par une accolade
       (statement-case-open . 0)
       ;; Instruction suivant une instruction de test ou de contrôle de boucle
       (substatement . +)
       ;; Accolade suivant une instruction de test ou de contrôle de boucle
       (substatement-open . 0)
       ;; Accolade ouvrante d'une énumération ou d'un tableau statique
       (brace-list-open . 0)
       ;; Accolade fermante d'une énumération ou d'un tableau statique
       (brace-list-close . 0)
       ;; Première ligne d'une énumération ou d'un tableau statique
       (brace-list-intro . +)
       ;; Lignes suivantes d'une énumération ou d'un tableau statique
       (brace-list-entry . 0)
       ;; Lignes suivantes d'une énumération ou d'un tableau statique
       ;; commençant par une accolade ouvrante
       (brace-entry-open . 0)
       ;; Label d'un switch
       (case-label . +)
       ;; Label d'une classe (public, protected, private) en retrait d'un pas
       ;; par rapport à l'indentation normale au sein d'une classe (cf.
       ;; déclaration « inclass » plus bas).
       (access-label . -)
       ;; Autres labels
       (label . 0)
       ;; Ouverture de bloc
       (block-open . 0)
       ;; Fermeture de bloc
       (block-close . 0)
       ;; A l'intérieur d'une chaîne multi-ligne
       (string . c-lineup-dont-change)
       ;; Première ligne d'un commentaire
       (comment-intro . c-lineup-comment)
       ;; A l'intérieur d'un commentaire C multi-ligne
       (c . c-lineup-C-comments)
       ;; Accolade ouvrant une fonction
       (defun-open . 0)
       ;; Accolade fermant une fonction
       (defun-close . 0)
       ;; Code suivant l'accolade ouvrante d'une fonction
       (defun-block-intro . +)
       ;; Clause else d'une expression conditionnelle
       (else-clause . 0)
       ;; Clause catch d'une instruction try
       (catch-clause . 0)
       ;; Accolade ouvrant une déclaration de classe
       (class-open . 0)
       ;; Accolade fermant la déclaration de classe
       (class-close . 0)
       ;; Accolade ouvrante d'une méthode définie dans la classe elle-même
       ;; (inline)
       (inline-open . 0)
       ;; Accolade fermante de la méthode inline
       (inline-close . 0)
       ;; Alignement des opérateurs de flux (<< et >>) sur les opérateurs de
       ;; flux de la ligne précédente
       (stream-op . c-lineup-streamop)
       ;; Ligne incluse dans une déclaration de classe (double indentation car
       ;; les labels d'accès public, protected et private sont déjà indentés)
       (inclass . ++)
       ;; Accolade ouvrant un bloc en langage externe (extern "C" {})
       (extern-lang-open . 0)
       ;; Accolade fermant un bloc en langage externe
       (extern-lang-close . 0)
       ;; Indentation dans un bloc de langage externe
       (inextern-lang . +)
       ;; Accolade ouvrant un bloc d'espace de nom
       (namespace-open . 0)
       ;; Accolade fermant un bloc d'espace de nom
       (namespace-close . 0)
       ;; Indentation dans un bloc d'espace de nom
       (innamespace . +)
       ;; Première ligne d'héritage
       (inher-intro . +)
       ;; Lignes suivantes d'héritage
       (inher-cont . c-lineup-multi-inher)
       ;; Première ligne de la liste d'initialisation
       (member-init-intro . +)
       ;; Lignes suivantes de la liste d'initialisation
       (member-init-cont . c-lineup-multi-inher)
       ;; Lignes entre la déclaration de fonction et l'accolade ouvrante. En
       ;; C, il n'y a rien mais en C++, il y a les listes d'initialisation
       (func-decl-cont . +)
       ;; Première ligne d'une macro (avec un décalage négatif excessif afin
       ;; d'être certain qu'elle reste collée à gauche en toute circonstance
       (cpp-macro . -1000)
       ;; Lignes suivantes d'une macro
       (cpp-macro-cont . c-lineup-dont-change)
       ;; Fonction amie
       (friend . 0)
       ;; while qui termine une instruction do { ... } while (...);
       (do-while-closure . 0)
       ;; Bloc d'instruction à l'intérieur d'une expression
       (inexpr-statement . 0)
       ;; Définition de classe à l'intérieur d'une expression (cela n'a de
       ;; sens qu'en Java mais autant définir ce contexte au cas où...)
       (inexpr-class . +)
       ;; Lignes autres que la première d'un modèle de fonction ou de classe
       (template-args-cont . +)
       ;; Arguments d'une fonction à la sauce K&R
       (knr-argdecl-intro . +)
       (knr-argdecl . 0)))
    (c-echo-syntactic-information-p . t)
  )
  "My C Programming Style"
)


;; Faire du style défini ci-dessus le style C/C++ par défaut
(defun my-c-mode-common-hook ()
  (c-add-style "PERSONAL" my-c-style t)
)
(add-hook 'c-mode-hook 'my-c-mode-common-hook)
(add-hook 'c++-mode-hook 'my-c-mode-common-hook)
