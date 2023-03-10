(module nvim-startify.utils.config
        {autoload {fortune nvim-startify.fortune.init}
         require-macros [nvim-startify.katcros-fnl.macros.nvim.api.options.macros
                         nvim-startify.katcros-fnl.macros.nvim.api.utils.macros]})

;;; Module: handle config hotloading

;; FN: Handle boolean based vim variables
;; @var-name: String -- name of variable
;; @scope: String -- scope of variable
;; @truthy: value to return when variable is true
;; @falsy: value to return when variable is false
(defn handle-vim-var [var-name scope truthy falsy]
  "Handles conditonal returning vim variables cleanly
@var-name -- String: the vim variable name
@scope -- String: the scope from vim (g, b, etc...)
@truthy -- value to return when variable is true
@falsy -- value to return when variable is false"
      (if (= (. (. vim scope) var-name) 0) falsy
          (> (. (. vim scope) var-name) 0) truthy))

;;; Key-val: A table of values used in startify options
(def value {:relative-path ":~:."
            :absolute-path ":p:~"})

;;; Key-val: A table of default configuration values for startify
(def default {:transformations (or (get-var :g :startify_transformations) [])
              :bookmarks (or (get-var :g :startify_bookmarks) [])
              :display-lists (or (get-var :g :startify_lists)
                                 [{:type :files :header "   MRU"}
                                  {:type :dir :header (.. "   MRU "  (do-viml getcwd))}
                                  {:type :sessions :header "   Sessions"}
                                  {:type :bookmarks :header "   Bookmarks"}
                                  {:type :commands :header "   Commands"}])
              :commands (or (get-var :g :startify_commands) [])
              :custom-index (or (get-var :g :startify_custom_indices) nil)
              :custom-header (if (get-var :g :startify_custom_header)
                                 (do (vim.notify "vim.g.startify_custom_header must be converted manually
Defaulting to an empty value" vim.log.levels.WARN) [""])
                                 (fortune.init))
              :custom-header-quote (or (get-var :g :startify_custom_header_quotes) [])
              :custom-footer (or (get-var :g :startify_custom_footer) "")
              :session {:dir (or (get-var :g :startify_session_dir)
                                 (.. (do-viml stdpath "data") "/session"))
                        :autoload (if (get-var :g :startify_session_autoload)
                                      (handle-vim-var :startify_session_autoload :g
                                                      true false)
                                      false)
                        :remove-lines (or (get-var :g :startify_session_remove_lines) [])
                        :save-vars (or (get-var :g :startify_session_savevars) [])
                        :save-cmds (or (get-var :g :startify_session_savecmds) [])
                        :number (or (get-var :g :startify_session_number) 999)
                        :persistence (if (get-var :g :startify_session_persistence)
                                         (handle-vim-var :startify_session_persistence :g
                                                         true false)
                                         false)
                        :sort-time (if (get-var :g :startify_session_sort)
                                       (handle-vim-var :startify_session_sort :g
                                                       true false)
                                       false)
                        :pre-commands (or (get-var :g :startify_session_before_save) [])
                        :del-buf-on-session (if (get-var :g :startify_session_delete_buffers)
                                              (handle-vim-var :startify_session_delete_buffers :g
                                                              true false)
                                              true)}
              :settings {:show-env (if (get-var :g :startify_use_env)
                                       (handle-vim-var :startify_use_env
                                                       true false)
                                       false)
                         :server-skiplist (or (get-var :g :startify_skiplist_server) [])
                         :use-relative-path (if (get-var :g :startify_relative_path)
                                                (handle-vim-var :startify_relative_path :g
                                                                value.relative-path
                                                                value.absolute-path)
                                                value.relative-path)
                         :change-to-dir (if (get-var :g :startify_change_to_dir)
                                          (handle-vim-var :startify_change_to_dir :g
                                                          true false)
                                          true)
                         :change-to-vcs-root (if (get-var :g :startify_change_to_vcs_dir)
                                               (handle-vim-var :startify_change_to_vcs_dir :g
                                                               true false)
                                               false)
                         :chdir-cmd (or (get-var :g :startify_change_cmd) :lcd)
                         :fortune-unicode (if (get-var :g :startify_fortune_use_unicode)
                                            (handle-vim-var :startify_fortune_use_unicode :g
                                                            true false)
                                            false)
                         :skiplist (let [list (or (get-var :g :startify_skiplist) [])]
                                     (table.insert list "runtime/doc/.*\\.txt$")
                                     (table.insert list "bundle/.*/doc/.*\\.txt$")
                                     (table.insert list "plugged/.*/doc/.*\\.txt$")
                                     (table.insert list "/\\.git/")
                                     (table.insert list "fugitiveblame$")
                                     (table.insert list
                                                   (.. (do-viml escape
                                                                (do-viml fnamemodify
                                                                         (do-viml resolve
                                                                                  (do-viml getenv "VIMRUNTIME"))
                                                                         ":p")
                                                                "\\")
                                                       "doc/.*\\.txt$"))
                                     list)
                         :list-number (or (get-var :g :startify_files_number) 10)
                         :show-special (if (get-var :g :startify_enable_special)
                                         (handle-vim-var :startify_relative_path :g
                                                         true false)
                                         true)
                         :on-vimenter (if (get-var :g :startify_disable_at_vimenter)
                                        (handle-vim-var :startify_disable_at_vimenter
                                                        false true)
                                        true)
                         :update-old-files (if (get-var :g :startify_update_old_files)
                                             (handle-vim-var :startify_update_old_files :g
                                                             true false)
                                             false)}
              :format {:align :center-page
                       :padding (or (get-var :g :startify_padding_left) 3)
                       :page-width 80
                       :above-spacing 1
                       :below-spacing 0}
              :render-order [[:title-global-files :title]
                             [:list-most-recent-files :list]]})

;;; Key-val: Table of configuration values
(def opts {})

;;; FN: Return value from config table
;;; @value: String -- The value desired
;;; @?nest: String -- The nested table value
(fn _G.startify_value [value ?nest] "Return a value from the config table
@value: String -- The value desired
@?nest: String -- The nested table value"
      (if ?nest
        (. (. opts ?nest) value)
        (. opts value)))

;;; FN: hotload config options, mutating 'opts' table
;;; @config: Key/val -- config options
(defn hotload [config] "Loads in config from settings
@config -- Key/val: The table of startify configs"
      (if config
        (let [out (vim.tbl_deep_extend :force default config)]
          (each [k v (pairs out)]
            (tset opts k v)))
        (each [k v (pairs default)]
          (tset opts k v))))

;;; FN: Is servername in skiplist?
;;; Returns true if vim.v.servername was in server skiplist
(defn server-skipped? [] "Sees if the current server needs to be skipped
Returns true if vim.v.servername was in server skiplist"
      (let [found? []]
        (each [_ server (ipairs opts.settings.server-skiplist) :until (> (length found?) 0)]
          (if (= server vim.v.servername)
            (table.insert found? true)))
        (if (> (length found?) 0)
          true
          false)))

