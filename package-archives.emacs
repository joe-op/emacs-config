;;; Add MELPA as a package source

;; right after (package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
;; the stable package source
;; I had to use this for some package that wasn't showing up
;; in the bleeding edge source
;;             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
