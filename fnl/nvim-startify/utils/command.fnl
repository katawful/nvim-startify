(module nvim-startify.utils.command
        {autoload {session-load nvim-startify.utils.session.loader
                   session-write nvim-startify.utils.session.write}
         require-macros [nvim-startify.katcros-fnl.macros.nvim.api.utils.macros]})

;;; Module: generate and run user-commands

;;; FN: Completion function for user command 'SLoad'
(defn completion-sload [] "Completion for user command 'SLoad'"
      {})
;;; FN: Completion function for user command 'SSave'
(defn completion-ssave [] "Completion for user command 'SSave'"
      {})
;;; FN: Completion function for user command 'SDelete'
(defn completion-sdelete [] "Completion for user command 'SDelete'"
      {})

;;; FN: Initialization for module
(defn init [] "Initialization"
      (cre-command :SLoad (fn [args] (session-load.init args.bang args.fargs))
                          {:nargs "?"
                           :bang true
                           :bar true
                           :complete completion-sload})
      (cre-command :SSave (fn [args] (session-write.save args.bang args.fargs))
                          {:nargs "?"
                           :bang true
                           :bar true
                           :complete completion-ssave})
      (cre-command :SDelete (fn [args] (session-delete.init args.bang args.fargs))
                            {:nargs "?"
                             :bang true
                             :bar true
                             :complete completion-sdelete}))
