(module nvim-startify.utils.file
        {autoload {a nvim-startify.aniseed.core
                   ext nvim-startify.utils.extmark
                   high nvim-startify.utils.highlight
                   config nvim-startify.utils.config
                   data nvim-startify.utils.data
                   builtin nvim-startify.render.builtins
                   fortune nvim-startify.fortune.init}
         require-macros [nvim-startify.katcros-fnl.macros.nvim.api.options.macros
                         nvim-startify.katcros-fnl.macros.nvim.api.utils.macros]})

;;; Module: direct management of the startify "file" itself
;;; This is stuff like character position, line setting, etc...

;;; Key-val: stores information for startify page
;;; Each key is a buffer number for the startify buffers
;;; Key: (b) if the key is buffer local
;;; global-index-state (b): Indeterminate Seq -- holds last used global index
;;; global-index-position (b): Mutable Number -- holds the last global index position
;;; namespace: Number -- namespace to use for startify
;;; TODO: I eventually want to expand this to unique startify pages
(def startify {})

;;; FN: Get some value from the file.startify value table
;;; @buffer: Number -- represents buffer
;;; variarg: values to get from startify
;;; Returns value
(defn get-value [buffer ...] "Get a value from startify values table
This simplifies syntax due to verbosity in fennel
@buffer: Number -- represents buffer
variarg: values to get from startify
Returns value"
      (let [vals [...]]
        (match (length vals)
          1 (?. (?. startify buffer) (. vals 1))
          2 (?. (?. (?. startify buffer) (. vals 1)) (. vals 2))
          3 (?. (?. (?. startify buffer) (. vals 1)) (. vals 2) (. vals 3)))))

;;; FN: Set value(s) for a startify buffer
;;; @buffer: Number -- represents a buffer
;;; @opt: Key/val -- table of options
;;; Modifies the file.startify table
(defn set-start-values [buffer opt] "Set value(s) for a startify buffer
@buffer: Number -- represents a buffer
@opt: Key/val -- table of options
Modifies the file.startify table"
      (each [k v (pairs opt)]
        (tset (. startify buffer) k v)))

;;; FN: Removes a specific key from a sequential table
;;; @seq: Seq -- the table to remove from
;;; @key: value to remove from seq
;;; Returns modified seq
(defn- remove-from-seq-tbl [seq key] "Removes a key from a sequential table
@seq: Seq -- the table to remove from
@key: value to remove from seq
Returns modified seq"
       (let [output []]
         (each [_ val (ipairs seq)]
           (if (not= key val)
             (table.insert output val)))
         output))

;;; FN: Adds oldfile to oldfiles
;;; @file: String -- file path
(defn update-oldfiles [file] "Adds oldfile to oldfiles
@file: String -- file path"
      (if (or (= (get-var :g :startify_locked) 0)
              (= (get-var :g :startify_locked) nil)
              (do-viml exists "v:oldfiles"))
        (do
          (remove-from-seq-tbl (get-var :v :oldfiles) file)
          (table.insert (get-var :v :oldfiles) 0 file))))

;;; FN: Get last line of buffer
;;; @buffer: Number -- represents a buffer
;;; Returns last line of buffer
(defn lastline [buffer] "Get last line of buffer
@buffer: Number -- represents a buffer
Returns last line of buffer"
      (length (vim.api.nvim_buf_get_lines buffer 0 -1 false)))

;; FN: Global version of lastline
(fn _G.startify_lastline [buffer] "Global version of lastline"
    (lastline buffer))

;;; String: filesystem separator
(def separator (if (do-viml has :win32) "\\" "/"))

;;; FN: Function return of filesystem separator
(fn _G.startify_fn_separator [] separator)

;;; FN: Inserts blankline into file
;;; @buffer: Number -- represents a buffer
;;; @amount: Number -- amount of blanklines to insert
;;; Returns amount inserted
(defn insert-blankline [buffer amount] "Inserts blank lines into file
Returns amount inserted
@buffer: Number -- buffer to use
@amount: Number -- amount of blanklines to insert
Returns amount inserted"
      (for [i 1 amount]
        (vim.api.nvim_buf_set_lines buffer -1 -1 false [""])))

;;; FN: Get amount of padding for center to window alignment
;;; @content: String -- the line that needs padding
;;; Returns the amount of padding for the left hand side of the content
(defn center-align-window [content]
  "Get the amount of padding for center window alignment
This will add padding from the left-most side of the content
To do this, we get the amount of characters to the middle of the content
@content: String -- the line that needs padding
Returns the amount of padding for the left hand side of the content"
      (let [win-width (vim.api.nvim_win_get_width 0)
            ;; number of characters to middle
            content-middle (math.floor (/ (length content) 2))
            win-middle (math.floor (/ win-width 2))]
        (- win-middle content-middle)))

;;; FN: Get amount of padding for right to window alignment
;;; @content: String -- the line that needs padding
;;; @padding: Number -- the amount of padding to add to the rhs of content
;;; Returns the amount of padding for the left hand side of the content
(defn right-align-window [content padding]
  "Get the amount of padding for right window alignment
This will add padding from the left-most side of the content
To do this, we get the amount of characters to the middle of the content
With padding passed, this will push the content further to the left
@content: String -- the line that needs padding
@padding: Number -- the amount of padding to add to the rhs of content
Returns the amount of padding for the left hand side of the content"
      (let [win-width (vim.api.nvim_win_get_width 0)
            content-width (length content)]
        (- win-width
           content-width
           (if padding padding 0)))) ; padding is optional

;;; FN: Get amount of padding for left to window alignment
;;; @content: String -- the line that needs padding
;;; @padding: Number -- the amount of padding to add to the lhs of content
;;; Returns the amount of padding for the left hand side of the content
(defn left-align-window [content padding]
  "Get the amount of padding for left window alignment
This will add padding from the left-most side of the content
To do this, we get the amount of characters to the middle of the content
@content: String -- the line that needs padding
Returns the amount of padding for the left hand side of the content"
      padding)

;;; FN: Get amount of padding for center to page alignment
;;; @content: String -- the line that needs padding
;;; Returns the amount of padding for the left hand side of the content
(defn center-align-page [content]
  "Get the amount of padding for center page alignment
This will add padding from the left-most side of the content
To do this, we get the amount of characters to the middle of the content
@content: String -- the line that needs padding
Returns the amount of padding for the left hand side of the content"
      (let [win-width (vim.api.nvim_win_get_width 0)
            ;; number of characters to middle
            content-middle (math.floor (/ (length content) 2))
            page-width config.opts.format.page-width
            page-middle (math.floor (/ page-width 2))
            page-margin (math.floor (/ (- win-width page-width) 2))
            win-middle (math.floor (/ win-width 2))]
        (+ page-margin
           (- page-middle content-middle))))

;;; FN: Get amount of padding for right to page alignment
;;; @content: String -- the line that needs padding
;;; @padding: Number -- the amount of padding to add to the rhs of content
;;; Returns the amount of padding for the left hand side of the content
(defn right-align-page [content padding]
  "Get the amount of padding for right page alignment
This will add padding from the left-most side of the content
To do this, we get the amount of characters to the middle of the content
With padding passed, this will push the content further to the left
@content: String -- the line that needs padding
@padding: Number -- the amount of padding to add to the rhs of content
Returns the amount of padding for the left hand side of the content"
      (let [win-width (vim.api.nvim_win_get_width 0)
            content-width (length content)
            page-width config.opts.format.page-width
            page-margin (math.floor (/ (- win-width page-width) 2))]
        (+ page-margin
           (- page-width
              content-width
              (if padding padding 0))))) ; padding is optional

;;; FN: Get amount of padding for left to page alignment
;;; @content: String -- the line that needs padding
;;; @padding: Number -- the amount of padding to add to the lhs of content
;;; Returns the amount of padding for the left hand side of the content
(defn left-align-page [content padding]
  "Get the amount of padding for left page alignment
This will add padding from the left-most side of the content
To do this, we get the amount of characters to the middle of the content
@content: String -- the line that needs padding
Returns the amount of padding for the left hand side of the content"
      (let [win-width (vim.api.nvim_win_get_width 0)
            content-width (length content)
            page-width config.opts.format.page-width
            page-margin (math.floor (/ (- win-width page-width) 2))]
        (+ page-margin padding)))

;;; FN: Run and return an alignment function
;;; @align-type String -- the string to describe alignment to use
;;; @content: String -- the string of content
;;; @padding: Number -- amound of padding to add if needed
(defn alignment [align-type content padding]
      (match align-type
        :right-window (right-align-window content padding)
        :right-page (right-align-page content padding)
        :left-window (left-align-window content padding)
        :left-page (left-align-page content padding)
        :center-window (center-align-window content)
        :center-page (center-align-page content)
        _ (do (vim.notify "Invalid alignment value" vim.log.levels.ERROR) 0)))

;;; FN: Create whitespace string of some length
;;; @amount: Number -- amount of whitespace to add
;;; Returns whitespace string
(defn padded-string [amount] "Create whitespace string of some length
@amount: Number -- amount of whitespace to add
Returns whitespace string"
      (let [amount (if amount amount 0)]
        (var str "")
        (for [i 1 amount] (set str (.. str " ")))
        str))

;;; FN: Padded whitespace string for keymap string '[%s]%s%s'
;;; 1 - keymap
;;; 2 - padding to content
;;; 3 - content
;;; The key strings should all be at the same column
;;; We will keep the keymap string at the edges of the page
;;; Padding on the keymap will be allowed likely
;;; @keymap: String -- the keys to present
;;; @content: String -- the line that needs to be added
;;; @format: Text format table
;;; @typer: String -- the type of entry
;;; @index: Number -- the current entry index
(defn pad-key-string [keymap content format typer index] "Pad a key string
This will align the key string with the left page or window only
@keymap: String -- the keys to present
@content: String -- the line that needs to be added
@format: Text format table
@typer: String -- the type of entry
@index: Number -- the current entry index"
      (let [key-string builtin.key-string
            padding (or format.padding config.opts.format.padding)
            align (or format.align config.opts.format.align)
            win-or-page (if (string.find align :window) :win :page)
            page-padding (if (= win-or-page :win)
                           (left-align-window key-string padding)
                           (left-align-page key-string padding))
            aligned-key-string (string.format "%s%s"
                                        (padded-string page-padding)
                                        key-string)
            ;; We need to factor in how the page is rendered
            win-width (vim.api.nvim_win_get_width 0)
            page-width config.opts.format.page-width
            page-margin (if (= win-or-page :page)
                          (math.floor (/ (- win-width page-width) 2))
                          0)
            keymap-length (string.len (tostring keymap))
            content-padding (padded-string
                              (- (alignment align content padding)
                                 keymap-length page-margin 2 padding))
            line [startify.current-line startify.current-line]
            content-col [(+ page-padding ; to keystring
                           2 ; [ and ]
                           (length (tostring keymap)) ; keymap
                           (length content-padding) ; to content
                           1) ; to match up to content
                         (+ page-padding ; to keystring
                            2 ; [ and ]
                            (length (tostring keymap)) ; keymap
                            (length content-padding) ; to content
                            (length content))] ;content
            key-col [(+ page-padding ; to keystring
                        1 ; first [
                        1) ; line up
                     (+ page-padding ; to keystring
                        1 ; first [
                       (length (tostring keymap)))]] ; end of keymap

        (data.insert-entry {: line
                            :col content-col
                            :ext (ext.add startify.working-buffer
                                          line
                                          content-col
                                          nil)})
        (data.insert-key {:line [startify.current-line startify.current-line]
                          :col key-col
                          :map (tostring keymap)
                          :ext (ext.add startify.working-buffer
                                        line
                                        key-col
                                        nil)}
                         index)
        (data.set-ify-value startify.working-ify :type typer)

        (string.format aligned-key-string keymap content-padding content)))

;;; FN: Add a line of content to startify buffer
;;; @buffer: Number -- represents a buffer
;;; @content: String -- a single line of text to add to file
;;; @pos: Number -- the line number to place content
;;; @format: Key/val -- a formatting table
(defn add-line [buffer content pos format] "Adds a single line of content to buffer
This only adds a line to the buffer
The full IFY implementation uses this function repeatedly
@buffer: Number -- represents a buffer
@contents: String -- a single line of text to add to file
@format: Key/val -- a formatting table"
      (let [align (if format.align format.align
                    config.opts.format.align)
            padding (alignment align content
                               (if format.padding format.padding
                                   config.opts.format.padding))
            padded-content (string.format "%s%s"
                                          (padded-string padding)
                                          content)
            pos (- pos 1) ; nvim api is 0 index which is confusing
            col [(+ padding 1) (+ (length content) padding)]]
        (data.set-ify-value startify.working-ify :line [(+ pos 1) (+ pos 1)])
        (data.set-ify-value startify.working-ify :col col)
        (data.insert-ify-extmark (ext.add buffer
                                          [pos pos]
                                          col
                                          nil))
        (vim.api.nvim_buf_set_lines buffer
                                    pos
                                    pos
                                    false
                                    [padded-content])))

;;; FN: Add an entry line to buffer
;;; This skips an alignment step
;;; @buffer: Number -- represents a buffer
;;; @content: String -- a single line of text to add to file
;;; @pos: Number -- the line number to place content
;;; @format: Key/val -- a formatting table
(defn add-entry-line [buffer content pos format] "Adds an entry line to buffer
This skips alignment as it is passed to keymap padding
This only adds a line to the buffer
The full IFY implementation uses this function repeatedly
@buffer: Number -- represents a buffer
@contents: String -- a single line of text to add to file
@format: Key/val -- a formatting table"
      (let [pos (- pos 1)] ; nvim api is 0 index which is confusing
        (vim.api.nvim_buf_set_lines buffer
                                    pos
                                    pos
                                    false
                                    [content])))

;;; FN: Add an art string to line
;;; @buffer: Number -- represents a buffer
;;; @content: String -- a single line of text to add to file
;;; @pos: Number -- the line number to place content
;;; @format: Key/val -- a formatting table
;;; @width: Number -- the size that the string is, for art IFYs
(defn add-string-line [buffer content pos format width] "Adds a string to buffer
This only adds a line to the buffer
The full IFY implementation uses this function repeatedly
@buffer: Number -- represents a buffer
@contents: String -- a single line of text to add to file
@format: Key/val -- a formatting table"
      (if (= (type content) :table)
        (let [align (or format.align config.opts.format.align)
              combined-content (do (var str "")
                                 (each [_ v (ipairs content)]
                                   (if (= (type v) :table)
                                     (set str (.. str (. v 1)))
                                     (set str (.. str v))))
                                 str)
              padding (alignment align (padded-string width)
                                 (or format.padding config.opts.format.padding))
              padded-content (string.format "%s%s"
                                            (padded-string padding)
                                            combined-content)
              pos (- pos 1)] ; nvim api is 0 index which is confusing
          (var str-length 0)
          (data.set-ify-value startify.working-ify
                              :col [(+ padding 1) (+ width padding)])
          (vim.api.nvim_buf_set_lines buffer
                                      pos
                                      pos
                                      false
                                      [padded-content])
          (each [_ v (ipairs content)]
            ;; Handle CCST
            (if (= (type v) :table)
              (let [hl-group (high.gen-hl-group :art)
                    color-table (. v 2)]
                (tset color-table :group hl-group)
                (high.highlight startify.namespace color-table)
                (data.insert-ify-extmark (ext.add startify.working-buffer
                                                  [startify.current-line
                                                   startify.current-line]
                                                  [(+ padding
                                                      str-length)
                                                   (+ padding
                                                      str-length
                                                      (string.len (. v 1)))]
                                                  hl-group
                                                  102))
                (set str-length (+ str-length (string.len (. v 1)))))
              (set str-length (+ str-length (string.len v))))))
        (let [align (or format.align config.opts.format.align)
              padding (alignment align (padded-string width)
                                 (or format.padding config.opts.format.padding))
              padded-content (string.format "%s%s"
                                            (padded-string padding)
                                            content)
              pos (- pos 1)] ; nvim api is 0 index which is confusing
          (data.set-ify-value startify.working-ify
                              :col [(+ padding 1) (+ width padding)])
          (vim.api.nvim_buf_set_lines buffer
                                      pos
                                      pos
                                      false
                                      [padded-content]))))

;;; FN: Grab the most recent files
;;; @file-number: Number -- the amount of recent files to return
(defn recent-files [file-number]
      (let [output []
            oldfiles vim.v.oldfiles]
        (for [i 1 file-number]
          (tset output i (. oldfiles i)))
        output))
