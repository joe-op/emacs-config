;;; Custom set variables
;;; added interactively through customize-group and friends

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(flycheck-highlighting-style '(conditional 4 (delimiters "" "«") (delimiters "" "«")))
 '(format-all-debug nil)
 '(format-all-show-errors 'never)
 '(inhibit-startup-screen t)
 '(package-enable-at-startup nil)
 '(package-selected-packages
   '(counsel projectile flycheck markdown-mode purescript-mode json-mode diff-hl))
 '(psc-ide-port 1550)
 '(ring-bell-function 'ignore)
 '(safe-local-variable-values
   '((psc-ide-source-globs "src/**/*.purs" "src/*.purs" "test/**/*.purs" "examples/**/*.purs")
     (psc-ide-source-globs "src/**/*.purs" "test/**/*.purs" "examples/**/*.purs"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
