(module nvim-startify.utils.extmark
        {autoload {file nvim-startify.utils.file
                   high nvim-startify.utils.highlight}})

;;; Module: Extmark management

;;; FN: Creates a namespace for the current buffer
;;; Adds value to file.startify table
(defn create-namespace [] "Creates a namespace for the current buffer"
      (tset file.startify :namespace (vim.api.nvim_create_namespace "startify")))

;;; FN: Add content to buffer and apply extmark
;;; Adjusted to 1 indexed rows for clarity
;;; @buffer: Number -- the buffer to use
;;; @line: Seq -- lines
;;; @col: Seq -- cols
;;; @hl_group: String -- a string of a highlight group
;;; Returns extmark
(defn add [buffer line col hl-group priority] "Add content to buffer and apply extmark
Adjusted to 1 indexed rows for clarity
@buffer -- the buffer to use
@line: Seq -- lines
@col: Seq -- cols
@hl-group: String -- a string of a highlight group
Returns extmark"
      (let [start-line (- (. line 1) 1)
            end_row (- (. line 2) 1)
            start-col (- (. col 1) 1)
            end_col (. col 2)
            priority (or priority 101)]
        (vim.api.nvim_buf_set_extmark buffer
                                      file.startify.namespace
                                      start-line
                                      start-col
                                      {: end_row
                                       : end_col
                                       :strict false
                                       : hl_group
                                       : priority})))
