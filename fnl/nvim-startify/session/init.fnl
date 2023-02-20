(module nvim-startify.session.init
        {autoload {config nvim-startify.utils.config}
         require-macros [nvim-startify.katcros-fnl.macros.nvim.api.utils.macros]})

;;; Module: session management

;;; FN: Returns expanded session path
(defn path [] "Returns expanded session path"
      (-> config.opts.session-dir
          (do-viml resolve)
          (do-viml expand)))
