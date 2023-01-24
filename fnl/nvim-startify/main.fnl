(module nvim-startify.main
        {autoload {autocmd nvim-startify.utils.autocmd
                   command nvim-startify.utils.command
                   map nvim-startify.utils.map
                   configs nvim-startify.utils.config
                   fortune nvim-startify.fortune.init
                   a nvim-startify.aniseed.core}
         require-macros [nvim-startify.katcros-fnl.macros.nvim.api.options.macros
                         nvim-startify.katcros-fnl.macros.nvim.api.utils.macros]})

;;; Module: main plugin interface
;;; Sets up everything needed, diverting functionality between modules

;; Key-val -- A table of values used in startify options
(def value {:relative-path ":~:."
            :absolute-path ":p:~"})

;; FN -- Easily accessible module to pass config to hotloader
(defn config [opts] "Pass options to be loaded"
      (configs.hotload opts))

(defn init []
  (print "HI")
  (if (a.empty? configs.opts)
    (configs.hotload))
  (autocmd.init)
  (command.init)
  (map.init)
  (print "BYE"))
