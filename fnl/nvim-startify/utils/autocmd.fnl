(module nvim-startify.utils.autocmd
        {autoload {render nvim-startify.render.init
                   file nvim-startify.utils.file}
         require-macros [nvim-startify.katcros-fnl.macros.nvim.api.autocommands.macros
                         nvim-startify.katcros-fnl.macros.nvim.api.options.macros
                         nvim-startify.katcros-fnl.macros.nvim.api.utils.macros]})

;;; Module: generate and run autocmds

(def startify-aug (def-aug- "startify"))

(defn- get-arglist [] "Get arglist
Returns number of files opened with nvim"
       (do-viml argc))

(defn- is-buf-empty? [buf] "Get the length of the buffer to see if empty
Returns true if empty"
       (let [buf-lines (vim.api.nvim_buf_get_lines buf 0 -1 false)
             buf-length (length buf-lines)]
         ;; nvim_buf_get_lines will return a table with an empty string if buffer exists
         ;; -- and is empty. this has to be checked out specifically
         (if (> buf-length 0)
           (do (if (and (= buf-length 1) (= (length (. buf-lines 1)) 0))
                 true
                 false))
           true)))

(defn- on-empty-session [] "Behavior for empty Neovim sessions"
       (if (and (= (get-arglist) 0) (is-buf-empty? 0))
         (if (and (get-var :g :startify_session_autoload) (do-viml filereadable "Session.vim"))
             (vim.cmd.source "Session.vim")
             (or (= (get-var :g :startify_disable_at_vimenter) 0)
                 (= (get-var :g :startify_disable_at_vimenter) nil))
             (render.init))))

(defn- update-oldfiles [] "Updating oldfiles"
       (if (= (get-var :g :startify_update_oldfiles) 1)
         (aug- startify-aug
               (auc- [:BufNewFile :BufRead :BufFilePre] "*"
                     (fn [args] (file.update-oldfiles
                                  (do-viml expand (.. "<afile>" ":p"))))))))

(defn on-vimenter [] "Runs for autocmd 'VimEnter'"
      (on-empty-session)
      (update-oldfiles))

(defn init [] "Initialization"
        (aug- startify-aug
              (auc- :VimEnter "*" (fn [] (on-vimenter)) {:nested true})))
