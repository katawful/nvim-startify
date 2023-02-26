(module nvim-startify.utils.highlight)

;;; Module: Handle highlighting

;;; Key/val: highlight groups for specific items
(def groups {:header {:link :Title
                      :name :StartifyHeader}
             :special {:link :Comment
                       :name :StartifySpecial}
             :directory {:link :Directory
                         :name :StartifyFile}})

;;; The following functions return specific values from the highlight table

(defn group [table] "Get the group name of a highlight group" (?. table :group))

(defn gui-fg [table] "Get the gui foreground of a highlight group"
      (?. table :fg))

(defn gui-bg [table] "Get the gui background of a highlight group"
      (?. table :bg))

(defn term-fg [table] "Get the term foreground of a highlight group"
      (?. table :ctermfg))

(defn term-bg [table] "Get the term background of a highlight group"
      (?. table :ctermbg))

(defn special [table] "Get the special colors of a highlight group"
      (?. table :sp))

(defn blend [table] "Get the blend of a highlight group" (?. table :blend))

(defn link [table] "Get the linking group for a highlight group"
      (?. table :link))

(defn default [table] "Get default key for a highlight group"
      (?. table :default))

(defn all-attr->table [table#] "Get the boolean attributes of a highlight group
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
      (let [group (get.group opts)
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
      ;; For now assume that a group that has a link will simply be empty otherwise
      (if (get.link opts)
          (let [group (get.group opts)
                link (get.link opts)
                args {: link}]
            (vim.api.nvim_set_hl namespace group args))
          ;; Key 'default'
          (get.default opts)
          (let [group (get.group opts)
                args (overwrite opts)]
            (vim.api.nvim_set_hl namespace group args))
          (let [group (get.group opts)
                gui-fore (if (and (not= (get.gui-fg opts) nil)
                                  (not= opts.fg :NONE) (not= opts.fg :SKIP))
                             opts.fg
                             nil)
                gui-back (if (and (not= (get.gui-bg opts) nil)
                                  (not= opts.bg :NONE) (not= opts.bg :SKIP))
                             opts.bg
                             nil)
                c-fore (if (and (not= (get.term-fg opts) nil)
                                (not= opts.ctermfg :NONE)
                                (not= opts.ctermfg :SKIP))
                           opts.ctermfg
                           nil)
                c-back (if (and (not= (get.term-bg opts) nil)
                                (not= opts.ctermbg :NONE)
                                (not= opts.ctermbg :SKIP))
                           opts.ctermbg
                           nil)
                args {:fg gui-fore
                      :bg gui-back
                      :ctermfg c-fore
                      :ctermbg c-back
                      :special (get.special opts)
                      :blend (get.blend opts)}]
            (each [k v (pairs (get.all-attr->table opts))]
              (tset args k v))
            (vim.api.nvim_set_hl namespace group args))))
