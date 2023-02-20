(module nvim-startify.utils.autocmd
        {autoload {render nvim-startify.render.init
                   file nvim-startify.utils.file
                   buffer nvim-startify.utils.buffer
                   session-write nvim-startify.session.write}
         require-macros [nvim-startify.katcros-fnl.macros.nvim.api.autocommands.macros
                         nvim-startify.katcros-fnl.macros.nvim.api.options.macros
                         nvim-startify.katcros-fnl.macros.nvim.api.utils.macros]})

;;; Module: generate and run autocmds

;;; String: autocommand group for startify
(def startify-aug (def-aug- "startify"))

;;; FN: Get vim argument list
;;; Returns the number of files opened via launch options
(defn- get-arglist [] "Get arglist
Returns number of files opened with nvim"
       (do-viml argc))

;;; FN: Runs for empty nvim sessions
;;; Will load a session if autoloading is enabled otherwise will render startify
(defn- on-empty-session [] "Behavior for empty Neovim sessions
Will load a session if autoloading is enabled otherwise will render startify"
       (if (and (= (get-arglist) 0) (buffer.empty? 0))
         (if (and (get-var :g :startify_session_autoload) (do-viml filereadable "Session.vim"))
             (vim.cmd.source "Session.vim")
             (or (= (get-var :g :startify_disable_at_vimenter) 0)
                 (= (get-var :g :startify_disable_at_vimenter) nil))
             (render.init true))))

;;; FN: Create autocommand that updates oldfiles if enabled
(defn- update-oldfiles [] "Creates autocommand that updates oldfiles if enabled"
       (if (= (get-var :g :startify_update_oldfiles) 1)
         (aug- startify-aug
               (auc- [:BufNewFile :BufRead :BufFilePre] "*"
                     (fn [args] (file.update-oldfiles
                                  (do-viml expand (.. "<afile>" ":p"))))
                     "Update old files on buffer change"))))

;;; FN: Callback for autocmd 'VimEnter'
(defn on-vimenter [] "Callback for autocmd 'VimEnter'"
      (on-empty-session)
      (update-oldfiles))

;;; FN: Callback for autocmd 'VimLeavePre'
(defn on-vimleavepre [] "Callback for autocmd 'VimLeavePre'"
      (if (and (> (get-var :g :startify_session_persistance) 0)
               (do-viml exists "v:this_session")
               (> (do-viml filewritable (get-var :v :this_session)) 0))
        (session-write.init (do-viml fnameescape (get-var :v :this_session)))))

;;; FN: Intialization of module
(defn init [] "Initialization of autocommands"
        (aug- startify-aug
              (auc- [:VimEnter] "*" (fn [] (on-vimenter)) "VimEnter" {:nested true})
              (auc- [:VimLeavePre] "*" (fn [] (on-vimleavepre)) "VimLeavePre" {:nested true})
              (auc- :QuickFixCmdPre "*vimgrep*"
                    (fn [] (set vim.g.startify_locked 1))
                    "QuickFixCmdPre")
              (auc- :QuickFixCmdPost "*vimgrep*"
                    (fn [] (set vim.g.startify_locked 0))
                    "QuickFixCmdPost")))
