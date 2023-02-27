(module nvim-startify.render.builtins
        {autoload {file nvim-startify.utils.file
                   config nvim-startify.utils.config}})

;;; Module: built in IFYs

;;; String: formatted string that builds '[%s] %s'
(def key-string "[%s] %s")

;;; IFY: List -- a list of the most recently used files
(def list-most-recent-files
     {:type :file
      :entries (file.recent-files config.opts.settings.list-number)})

;;; IFY: Title -- the title for most recent global files
(def title-global-files
     {:string "Most Recent Files"})

;;; FN: Get a built in option from a setting string
;;; @setting
(defn use [setting]
      (match setting
        :list-most-recent-files list-most-recent-files
        :title-global-files title-global-files))
