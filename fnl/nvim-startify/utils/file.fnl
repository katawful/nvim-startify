(module nvim-startify.utils.file
        {autoload {a nvim-startify.aniseed.core
                   config nvim-startify.utils.config
                   fortune nvim-startify.fortune.init}
         require-macros [nvim-startify.katcros-fnl.macros.nvim.api.options.macros
                         nvim-startify.katcros-fnl.macros.nvim.api.utils.macros]})

;;; Module: file management

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

;;; FN: Pad for center alignment
;;; Returns amount of padding for center alignment
(defn center-align [] "Pad for center alignment
Returns amount of padding for center alignment"
      (let [win-width (vim.api.nvim_win_get_width 0)
            content-width config.opts.width]
        (math.floor (/ (- win-width content-width) 2))))

;;; FN: Pad for right alignment
;;; Returns amount of padding for right alignment
(defn right-align [] "Pad for right alignment
Returns amount of padding for right alignment"
      (let [win-width (vim.api.nvim_win_get_width 0)
            content-width config.opts.width]
        (- win-width content-width)))

;;; FN: Get alignment values based on config setting
;;; Returns alignment value
(defn align-value [] "Get the needed padding values for alignment
Returns alignment value"
      (match config.opts.alignment
        :center (center-align)
        :left config.opts.left-padding
        :right (right-align)))

;;; FN: Aligns header to window
;;; @buffer: Number -- represents a buffer
;;; Returns alignment value
(defn header-align [buffer] "Aligns header to window
@buffer: Number -- represents a buffer
Returns alignment value"
      (let [win-width (vim.api.nvim_win_get_width 0)
            content-width (fortune.longest-line buffer)]
        (math.floor (/ (- win-width content-width) 2))))

;;; FN: Create whitespace string of some length
;;; @amount: Number -- amount of whitespace to add
;;; Returns whitespace string
(defn padding [amount] "Create whitespace string of some length
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
