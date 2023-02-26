(module nvim-startify.utils.file
        {autoload {a nvim-startify.aniseed.core
                   config nvim-startify.utils.config
                   fortune nvim-startify.fortune.init}
         require-macros [nvim-startify.katcros-fnl.macros.nvim.api.options.macros
                         nvim-startify.katcros-fnl.macros.nvim.api.utils.macros]})

;;; Module: direct management of the startify "file" itself
;;; This is stuff like character position, line setting, etc...

;; Key-val: stores information for startify page
;; Each key is a buffer number for the startify buffers
;; TODO: I eventually want to expand this to unique startify pages
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
          1 (. (. startify buffer) (. vals 1))
          2 (. (. (. startify buffer) (. vals 1)) (. vals 2))
          3 (. (. (. startify buffer) (. vals 1)) (. vals 2) (. vals 3)))))

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

;;; FN: Pad for center alignment of the window
;;; Returns amount of padding for center alignment
(defn center-align-window [] "Pad for center alignment
Returns amount of padding for center alignment"
      (let [win-width (vim.api.nvim_win_get_width 0)
            content-width config.opts.width]
        (math.floor (/ (- win-width content-width) 2))))

;;; FN: Pad for right alignment of the window
;;; Returns amount of padding for right alignment
(defn right-align-window [] "Pad for right alignment
Returns amount of padding for right alignment"
      (let [win-width (vim.api.nvim_win_get_width 0)
            content-width config.opts.width]
        (- win-width content-width)))

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
        :center-page (center-align-page)))

;;; FN: Create whitespace string of some length
;;; @amount: Number -- amount of whitespace to add
;;; Returns whitespace string
(defn- padding [amount] "Create whitespace string of some length
@amount: Number -- amount of whitespace to add
Returns whitespace string"
      (var str "")
      (for [i 1 amount] (set str (.. str " ")))
      str)

;;; FN: Pads content
;;; @buffer: Number -- represents a buffer
;;; @contents: Seq -- lines to pad
;;; @amount: Number -- amount of padding to add
(defn pad-contents [buffer contents amount] "Pads content
@buffer: Number -- represents a buffer
@contents: Seq -- lines to pad
@amount: Number -- amount of padding to add"
      (let [out []]
        (each [_ v (ipairs (get-value buffer :header :contents))]
          (table.insert out (.. (padding amount) v)))
        out))
