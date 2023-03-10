(module nvim-startify.utils.buffer
        {autoload {file nvim-startify.utils.file
                   extmark nvim-startify.utils.extmark}})

;;; Module: overview managment of the startify "file"
;;; This is stuff like options, state, etc...

(defn open [...] "open buffers"
      (print "BUFFERS OPENED"))

;;; FN: Is buffer empty?
;;; @buffer: Number -- represents a buffer
;;; Returns true when buffer is empty
(defn empty? [buffer] "Is buffer empty?
@buffer - a number, represents a buffer
Returns true when buffer is empty"
      (let [lines (vim.api.nvim_buf_get_lines buffer 0 -1 false)
            len (length lines)]
        (if (>= len 1)
          (if (and (= len 1) (= (. lines 1) ""))
            true
            false)
          true)))

;;; FN: Is buffer modifiable?
;;; @buffer: Number -- represents a buffer
;;; Returns true if buffer is modifiable
(defn modifiable? [buffer] "Is buffer modifiable?
@buffer - a number, represents a buffer
Returns true if buffer is modifiable"
      (if (vim.api.nvim_buf_get_option buffer :modifiable)
          true
          false))

;;; Key/val: options of startify buffer
(def startify-opts {:bufhidden :wipe
                    :colorcolumn :0
                    :foldcolumn :0
                    :matchpairs ""
                    :buflisted false
                    :cursorcolumn false
                    :cursorline false
                    :list false
                    :number false
                    :readonly false
                    :relativenumber false
                    :spell false
                    :swapfile false
                    :signcolumn :no})

;;; FN: Set buffer options for startify.
;;; This is currently unclean
;;; @buffer: Number -- represents buffer
(defn set-options [buffer] "Set buffer opts for startify
This isn't particularly clean, but it's needed to set some options properly
@buffer: Number -- represents buffer"
      (each [opt val (pairs startify-opts)]
        (tset vim.opt_local opt val))
      (vim.api.nvim_buf_set_option buffer :synmaxcol
                                   (. (vim.api.nvim_get_option_info :synmaxcol) :default))
      (if (not (vim.api.nvim_win_get_option 0 :statusline))
        (vim.api.nvim_win_set_option 0 :statusline "\\ startify"))
      (tset (. vim.bo buffer) :filetype :startify))

;;; FN: start the startify buffer
;;; @buffer: Number -- represents a buffer
(defn start [buffer] "start the startify buffer
@buffer: Number -- represents a buffer"
      (set-options buffer)

      ;; Insert an arbitrary amount of blanklines for easier implementation
      (file.insert-blankline buffer 1000))

;;; FN: unmodifies a buffer
;;; @buffer: Number -- represents a buffer
(defn unmodify [buffer] "Unmodify a buffer"
      (vim.api.nvim_buf_set_option buffer :modified false)
      (vim.api.nvim_buf_set_option buffer :modifiable false))

;;; FN: Is visible buffer modified
;;; @buffer: Number -- represents a buffer
;;; Returns true if the visible buffer is modified and warn the user
(defn visible-modified? [buffer] "Is visible buffer modified
@buffer - a number, represents a buffer
Returns true if the visible buffer is modified and warn the user"
      (if (and (vim.api.nvim_buf_get_option buffer :modified)
               (not (vim.api.nvim_buf_get_option buffer :hidden)))
          (do (vim.notify "Save your changes first.") true)
          false))

;;; Creates and inserts a new entry to the startify buffer
;;; Saves to startify memory
;;; Creates extmarks
;;; @buffer: Number -- startify buffer
;;; @line-num: Number -- line number to place the entry at
;;; @key: String -- the key mapping used for that entry
;;; @entry-type: String -- the type of entry for management
;;; @command: Function -- the command the entry runs
;;; @path: String: -- the path that the entry corresponds to
(defn new-entry [buffer
                 name
                 contents
                 hl-group
                 line-num
                 key
                 entry-type
                 command
                 language
                 path]
  "Creates and inserts a new entry to the startify buffer
Saves to startify memory
Creates extmarks
@buffer -- startify buffer
@line-num -- line number to place the entry at
@key -- the key mapping used for that entry
@entry-type -- the type of entry for management
@command -- the command the entry runs
@path -- the path that the entry corresponds to"
      (when (file.get-value buffer :entries) nil
        (tset (. file.startify buffer) :entries []))
      (table.insert (file.get-value buffer :entries)
                    {: line-num
                     : contents
                     : key
                     : entry-type
                     : command
                     : language
                     : path
                     :extmark (extmark.add buffer
                                       [contents]
                                       {:start-line line-num
                                        :end-line line-num
                                        :start-col 1
                                        :end-col (length contents)}
                                       hl-group
                                       true)}))
