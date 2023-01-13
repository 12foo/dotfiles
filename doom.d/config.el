;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(defconst autosave-directory (expand-file-name "emacs-autosave/" temporary-file-directory))
(unless (file-directory-p autosave-directory) (make-directory autosave-directory))
(setq backup-directory-alist `((".*" . ,autosave-directory)))
(setq auto-save-file-name-transforms `((".*" ,autosave-directory t)))

(setq doom-theme 'doom-palenight)
(setq doom-font (font-spec :family "JetBrains Mono" :size 13)
      doom-big-font (font-spec :family "JetBrains Mono" :size 18))

      ;; doom-variable-pitch-font (font-spec :family "Overpass" :size 24)
      ;; doom-unicode-font (font-spec :family "JuliaMono")
      ;; doom-serif-font (font-spec :family "IBM Plex Mono" :weight 'light)


(setq company-selection-wrap-around t)

(setq +lookup-open-url-fn #'+lookup-xwidget-webkit-open-url-fn)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Philipp Rustemeier"
      user-mail-address "philipp@rustemeier.it")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/rustemeier.it/org/")
(setq org-startup-folded 'showall)

(after! scala-mode
        (setq scala-indent:align-parameters nil))

(after! centaur-tabs
        (map! "C-<next>" #'centaur-tabs-forward)
        (map! "C-<prior>" #'centaur-tabs-backward)
        (setq centaur-tabs-set-icons nil))
        

(after! ox-latex
  (add-to-list 'org-latex-classes
               '("prit-report"
                 "
                        \\documentclass[paper=a4,headsepline,footsepline,pagenumber=off,twoside=false,headlines=4,titlepage=false]{scrreprt}
                        \\usepackage[T1]{fontenc}
                        \\usepackage[ngerman]{babel}
                        \\usepackage{fontspec}
                        \\usepackage{xcolor}
                        \\usepackage{parskip}
                        \\usepackage[colorlinks=true, linkcolor=teal]{hyperref}
                        \\usepackage[headsepline,footsepline,automark]{scrlayer-scrpage}

                        [DEFAULT-PACKAGES]
                        [PACKAGES]

                        \\setmainfont[Numbers={OldStyle,Monospaced}]{Titillium}
                        \\setmonofont{Fira Mono}

                        \\newcommand{\\dslash}{{\\color{gray}~/\\phantom{}/~}}

                        \\titlehead{
                                \\begin{minipage}[b]{.44\\linewidth}
                                {\\fontspec{Neogrey}[SizeFeatures={Size=22}]{\\fontsize{22pt}{22pt} rustemeier}} \\\\[-5pt]
                                {\\fontspec{Titillium}[SizeFeatures={Size=8},LetterSpace=5]{SOFTWARE \\dslash IT-DIENSTLEISTUNGEN}}
                                \\end{minipage}
                        \\hfill
                        \\begin{minipage}[b]{.55\\linewidth}\\begin{flushright}{\\footnotesize \\vspace*{5pt}
                                        Philipp Rustemeier \\dslash Geroldstr. 5 \\dslash 33098 Paderborn \\\\
                                        philipp\\,@\\,rustemeier.it
                                }\\end{flushright}\\end{minipage}
                        }
                        \\pagestyle{scrheadings}
                        \\renewcommand*{\\titlepagestyle}{empty}
                        \\renewcommand{\\chapterpagestyle}{scrheadings}
                        \\renewcommand*{\\chaptermarkformat}{}
                        \\renewcommand*{\\sectionmarkformat}{}
                        \\clearpairofpagestyles
                        \\ofoot[\\pagemark]{\\pagemark}
                        \\ifoot[\\headmark]{\\headmark}
                        \\areaset[0mm]{0.8\\paperwidth}{0.9\\paperheight}
                        \\setuptoc{toc}{leveldown}
                        "
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (setq org-latex-default-class "prit-report")
  (setq org-latex-compiler "lualatex"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

