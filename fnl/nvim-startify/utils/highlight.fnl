(module nvim-startify.utils.highlight
        {autoload {file nvim-startify.utils.file
                   config nvim-startify.utils.config
                   s nvim-startify.aniseed.string}})

;;; Module: Handle highlighting

;;; Key/val: highlight groups for specific items
(def groups {:header {:link :Title
                      :name :StartifyHeader}
             :special {:link :Comment
                       :name :StartifySpecial}
             :directory {:link :Directory
                         :name :StartifyFile}})

;;; The following functions return specific values from the highlight table

(defn get-group [table] "Get the group name of a highlight group" (?. table :group))

(defn get-gui-fg [table] "Get the gui foreground of a highlight group"
      (?. table :fg))

(defn get-gui-bg [table] "Get the gui background of a highlight group"
      (?. table :bg))

(defn get-term-fg [table] "Get the term foreground of a highlight group"
      (?. table :ctermfg))

(defn get-term-bg [table] "Get the term background of a highlight group"
      (?. table :ctermbg))

(defn get-special [table] "Get the special colors of a highlight group"
      (?. table :sp))

(defn get-blend [table] "Get the blend of a highlight group" (?. table :blend))

(defn get-link [table] "Get the linking group for a highlight group"
      (?. table :link))

(defn get-default [table] "Get default key for a highlight group"
      (?. table :default))

(defn get-all-attr->table [table#] "Get the boolean attributes of a highlight group
  as a table"
      (let [output {}]
        (each [k v (pairs table#)]
          ;; specifically look for non-nil values
          (if (or (= v true) (= v false))
              (do
                (if (= vim.g.kat_nvim_max_version :0.8)
                    (match k
                      :underlineline (tset output :underdouble v)
                      :underdot (tset output :underdotted v)
                      :underdash (tset output :underdashed v)
                      _ (tset output k v))
                    (do
                      (tset output k v))))))
        output))

;;; FN: get all existing values for the highlight group
;;; @group: String -- Highlight group to use
(defn get-existing [group] "Get existing highlights for a highlight group
@group: String -- group name"
      (let [gui (vim.api.nvim_get_hl_by_name group true)
            fg (utils.decimal-rgb->hex gui.foreground)
            bg (utils.decimal-rgb->hex gui.background)
            cterm (vim.api.nvim_get_hl_by_name group false)
            ctermfg cterm.foreground
            ctermbg cterm.background
            bold (?. gui :bold)
            underline (?. gui :underline)
            underlineline (?. gui :underlineline)
            undercurl (?. gui :undercurl)
            underdot (?. gui :underdot)
            underdash (?. gui :underdash)
            inverse (?. gui :inverse)
            italic (?. gui :italic)
            standout (?. gui :standout)
            nocombine (?. gui :nocombine)
            strikethrough (?. gui :strikethrough)
            blend (?. gui :blend)
            special (utils.decimal-rgb->hex (?. gui :special))]
        {: group
         : fg
         : bg
         : ctermbg
         : ctermfg
         : bold
         : underline
         : underlineline
         : undercurl
         : underdot
         : underdash
         : inverse
         : italic
         : nocombine
         : standout
         : strikethrough
         : blend
         : special}))

;;; FN: Overwrite the output using the default values when there
;;; @opts: Key/val -- color highlight table
(defn overwrite [opts] "Overwrite the values found for a group without clearing them out
@opts: Key/val -- highlight table"
      (let [group (get-group opts)
            current-hl (get-existing group)
            output (vim.tbl_extend :force current-hl opts)]
        (tset output :group nil)
        (tset output :default nil)
        output))

;;; FN: generate a highlight with the appropriate hex color inputs and group
;;; -- Uses nvim api for users of Neovim 0.7 and newer
;;; -- Has sideffects
;;; @namespace: Number -- the extmark namespace
;;; @opts: Key/val: -- Neovim standard table of highlight values
(defn highlight [namespace opts] "Nested highlight function that uses nvim api function to handle
highlighting for Neovim 0.7 and newer users
@namespace: Number -- the extmark namespace
@opts: Key/val -- highlight table"
      ;; Set the namespace to the one we are using
      (vim.api.nvim_set_hl_ns file.startify.namespace)
      ;; For now assume that a group that has a link will simply be empty otherwise
      (if (get-link opts)
          (let [group (get-group opts)
                link (get-link opts)
                args {: link}]
            (vim.api.nvim_set_hl namespace group args))
          ;; Key 'default'
          (get-default opts)
          (let [group (get-group opts)
                args (overwrite opts)]
            (vim.api.nvim_set_hl namespace group args))
          (let [group (get-group opts)
                gui-fore (if (and (not= (get-gui-fg opts) nil)
                                  (not= opts.fg :NONE) (not= opts.fg :SKIP))
                             opts.fg
                             nil)
                gui-back (if (and (not= (get-gui-bg opts) nil)
                                  (not= opts.bg :NONE) (not= opts.bg :SKIP))
                             opts.bg
                             nil)
                c-fore (if (and (not= (get-term-fg opts) nil)
                                (not= opts.ctermfg :NONE)
                                (not= opts.ctermfg :SKIP))
                           opts.ctermfg
                           nil)
                c-back (if (and (not= (get-term-bg opts) nil)
                                (not= opts.ctermbg :NONE)
                                (not= opts.ctermbg :SKIP))
                           opts.ctermbg
                           nil)
                args {:fg gui-fore
                      :bg gui-back
                      :ctermfg c-fore
                      :ctermbg c-back
                      :special (get-special opts)
                      :blend (get-blend opts)}]
            (each [k v (pairs (get-all-attr->table opts))]
              (tset args k v))
            (vim.api.nvim_set_hl namespace group args))))

;;; FN: Generates a unique, non-random hl group name
;;; This group can be used for unique components of an IFY
;;; This way we don't overload anything, but can also change out
;;; -- the group's components as needed
;;; The naming scheme is like so: Startify_IFY_1
;;; The first word is just a signifier for this plugin
;;; The second word is the type of IFY it is for
;;; The last item is an index that gets updated based on access
;;; @ify: String -- type of ify
(defn gen-hl-group [ify]
      ;; See if file.startify.hl-group exists
      (if file.startify.hl-group
        (do
          (let [out (string.format "Startify_%s_%s" ify file.startify.hl-group)]
            (set file.startify.hl-group (+ file.startify.hl-group 1))
            out))
        (do
          (set file.startify.hl-group 1)
          (let [out (string.format "Startify_%s_%s" ify file.startify.hl-group)]
            (set file.startify.hl-group (+ file.startify.hl-group 1))
            out))))

;;; FN: get the current possible generated hl-group
(defn get-hl-group [ify]
      (when file.startify.hl-group
        (string.format "Startify_%s_%s" ify file.startify.hl-group)))

;;; FN: Highlight any conjoined-color-string-tables and return the string line
;;; Each index of an art IFY's string key is a line to print
;;; There can be an unlimited number of CCST in each index
;;; We need to be able to print the single line of string
;;; We also need to highlight each part of the CCST if it exists
;;; @ify-string: String/seq-table -- The line from the IFY
;;; @ify: String -- what IFY we are using
(defn str [ify-string ify]
      (let [out-string []]
        (if (= (type ify-string) :table)
          (each [_ sub-string (ipairs ify-string)]
            ;; Handle CCST
            (if (= (type sub-string) :table)
              (do
                ;; Add string to output
                (table.insert out-string (. sub-string 1))
                ;; Highlight color-table
                (let [hl-group (gen-hl-group ify)
                      color-table (. sub-string 2)]
                  (tset color-table :group hl-group)
                  (highlight file.startify.namespace color-table)))
              (do
                ;; Handle non-CCST
                (table.insert out-string sub-string))))
          ;; Handle non-CCST
          (table.insert out-string ify-string))
        (s.join out-string)))
