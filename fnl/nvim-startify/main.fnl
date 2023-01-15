(module nvim-startify.main
        {autoload {autocmd nvim-startify.utils.autocmd}})

;;; Module: main plugin interface
;;; Sets up everything needed, diverting functionality between modules

(defn init []
  (print "HI")
  (autocmd.init)
  (print "BYE"))
