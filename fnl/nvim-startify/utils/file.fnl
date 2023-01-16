(module nvim-startify.utils.file
        {autoload {a nvim-startify.aniseed.core}
         require-macros [nvim-startify.katcros-fnl.macros.nvim.api.options.macros]})

;;; Module: file management

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

