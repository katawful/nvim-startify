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
;;; @contents: Seq -- the lines to add
;;; @placement: Key/val -- a table of how the extmark should be placed"
;;; @hl-group: String -- a string of a highlight group
;;; @pad?: Boolean -- do we apply padding
;;; Returns extmark
(defn add [buffer contents placement hl-group pad?] "Add content to buffer and apply extmark
Adjusted to 1 indexed rows for clarity
@buffer -- the buffer to use
@contents -- the lines to add, takes an array
@placement -- a table of how the extmark should be placed
@hl-group: String -- a string of a highlight group
@pad?: Boolean -- do we apply padding
Returns extmark"
      (let [padded-contents (do (let [out []]
                                  (each [_ v (ipairs contents)]
                                    (table.insert out
                                      (.. (file.padding (file.align-value))
                                          v)))
                                  out))
            padded-start-col (+ (file.align-value) placement.start-col)
            padded-end-col (+ (file.align-value) placement.end-col)]
        (vim.api.nvim_buf_set_lines buffer
                                    (- placement.start-line 1)
                                    (- placement.end-line 1)
                                    false
                                    (if pad? padded-contents contents))
        (vim.api.nvim_buf_set_extmark buffer
                                      file.startify.namespace
                                      (- placement.start-line 1)
                                      (if pad? padded-start-col placement.start-col)
                                      {:end_row (- placement.end-line 1)
                                       :end_col (if pad? padded-end-col placement.end-col)
                                       :strict false
                                       : hl_group})))
