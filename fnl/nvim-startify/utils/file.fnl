(module nvim-startify.utils.file
        {autoload {a nvim-startify.aniseed.core}
         require-macros [nvim-startify.katcros-fnl.macros.nvim.api.options.macros
                         nvim-startify.katcros-fnl.macros.nvim.api.utils.macros]})

;;; Module: file management

;; Key-val: stores information for startify page
;; TODO: I eventually want to expand this to unique startify pages
(def startify {:lastline -1})

(defn- remove-from-seq-tbl [seq key] "Removes a key from a sequential table"
       (let [output []]
         (each [_ val (ipairs seq)]
           (if (not= key val)
             (table.insert output val)))
         output))

(defn update-oldfiles [file] "Updates oldfiles with current file"
      (if (or (= (get-var :g :startify_locked) 0)
              (= (get-var :g :startify_locked) nil)
              (do-viml exists "v:oldfiles"))
        (do
          (remove-from-seq-tbl (get-var :v :oldfiles) file)
          (table.insert (get-var :v :oldfiles) 0 file))))

(defn lastline [buffer] "Returns the last line of startify page"
      (length (vim.api.nvim_buf_get_lines buffer 0 -1 false)))

(def separator (if (do-viml has :win32) "\\" "/"))
