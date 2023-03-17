(module nvim-startify.render.iterator
        {autoload {file nvim-startify.utils.file
                   high nvim-startify.utils.highlight
                   ext nvim-startify.utils.extmark
                   data nvim-startify.utils.data
                   config nvim-startify.utils.config
                   index nvim-startify.utils.index
                   builtin nvim-startify.render.builtins}})

;;; Module: Implements buffer iterator that places groups down with
;;; each pass of the iterator. It works through every line of the file,
;;; adding the needed groups at the appropriate lines

;;; FN: Should we skip line?
;;; Returns true if yes
(defn skip-line? []
  "Returns true if we can skip a line and continue looping")

;;; FN: loop through a title IFY
;;; @buffer: Number -- represents a buffer
(defn title-ify-loop [buffer ify]
      (let [ify-format (if ify.format
                         ify.format {})
            merged-format (vim.tbl_extend :keep
                                         ify-format
                                         config.opts.format)]
        (data.insert-ify-entry {:id file.startify.working-ify
                                :ify :title})
        (when merged-format.above-spacing
          (data.inc-cur-line merged-format.above-spacing))
        (file.add-line buffer
                       ify.string
                       file.startify.current-line
                       merged-format)

        ;; Deal with color table that might exist
        (when ify.color
          (let [hl-group (high.gen-hl-group :art)
                color-table ify.color
                ify-line (data.get-ify-value file.startify.working-ify :line)
                ify-col (data.get-ify-value file.startify.working-ify :col)]
            (tset color-table :group hl-group)
            (high.highlight file.startify.namespace color-table)
            ;; We need to highlight each line to not have runover
            (data.insert-ify-extmark (ext.add file.startify.working-buffer
                                              [(. ify-line 1) (. ify-line 2)]
                                              [(. ify-col 1) (. ify-col 2)]
                                              hl-group
                                              101))))

        (data.inc-cur-line 1)
        (when merged-format.below-spacing
          (data.inc-cur-line merged-format.below-spacing))))

;;; FN: loop through the entries key in a list IFY
;;; @buffer: Number -- represents a buffer
;;; @list-ify: IFY -- a list IFY
;;; @format: Key/val -- the format table already created
(defn entries-loop [buffer ify format]
      (let [entries-length (length ify.entries)
            names (if ify.names ify.names
                    ify.entries)]
        (data.set-ify-value file.startify.working-ify :entries [])
        (data.set-ify-value file.startify.working-ify :keys [])
        (for [i 1 entries-length]
          (file.add-entry-line buffer
                               (file.pad-key-string
                                 (index.get-next buffer)
                                 (. names i)
                                 format
                                 (. ify :type)
                                 i)
                               file.startify.current-line
                               format)
          (data.inc-cur-line 1))))

;;; FN: loop through a list IFY
;;; @buffer: Number -- represents a buffer
(defn list-ify-loop [buffer ify]
      (let [ify-format (if (?. ify :format)
                         ify.format {})
            merged-format (vim.tbl_extend :keep
                                          ify-format
                                          config.opts.format)]
        (data.insert-ify-entry {:id file.startify.working-ify
                                :ify :list
                                :type (. ify :type)})
        (when merged-format.above-spacing
          (data.inc-cur-line merged-format.above-spacing))
        (entries-loop buffer ify merged-format)
        (when merged-format.below-spacing
          (data.inc-cur-line merged-format.below-spacing))))

;;; FN: loop through the entries key in a art IFY
;;; @buffer: Number -- represents a buffer
;;; @art-ify: IFY -- an art IFY
;;; @format: Key/val -- the format table already created
(defn art-loop [buffer ify format]
      (let [height (. ify.size 2)]
        (data.set-ify-value file.startify.working-ify
                            :line [file.startify.current-line
                                   (+ file.startify.current-line
                                      (. ify.size 2))])
        (for [i 1 height]
          (file.add-string-line buffer
                                (. ify.string i)
                                file.startify.current-line
                                format
                                (. ify.size 1))
          (data.inc-cur-line 1))

        ;; Deal with color table that might exist
        (when ify.color
          (let [hl-group (high.gen-hl-group :art)
                color-table ify.color
                ify-line (data.get-ify-value file.startify.working-ify :line)
                ify-col (data.get-ify-value file.startify.working-ify :col)]
            (tset color-table :group hl-group)
            (high.highlight file.startify.namespace color-table)
            ;; We need to highlight each line to not have runover
            (for [i (. ify-line 1) (. ify-line 2)]
              (data.insert-ify-extmark (ext.add file.startify.working-buffer
                                                [i i]
                                                [(. ify-col 1) (. ify-col 2)]
                                                hl-group
                                                101)))))))

;;; FN: loop through a art IFY
;;; @buffer: Number -- represents a buffer
(defn art-ify-loop [buffer ify]
      (let [ify-format (if (?. ify :format)
                         ify.format {})
            merged-format (vim.tbl_extend :keep
                                          ify-format
                                          config.opts.format)]
        (data.insert-ify-entry {:id file.startify.working-ify
                                :ify :art})
        (when merged-format.above-spacing
          (data.inc-cur-line merged-format.above-spacing))
        (art-loop buffer ify merged-format)
        (when merged-format.below-spacing
          (data.inc-cur-line merged-format.below-spacing))))


;;; FN: Loop through a group
;;; @buffer: Number -- represents a buffer
;;; @ify: the IFY to process
(defn ify-loop [buffer to-ify]
  "Loop through an IFY"
      (let [ify (if (= (type (. to-ify 1)) :string)
                  (builtin.use (. to-ify 1))
                  (. to-ify 1))
            ify-type (. to-ify 2)]
        (match ify-type
          :title (title-ify-loop buffer ify)
          :list (list-ify-loop buffer ify)
          :art (art-ify-loop buffer ify))))

;;; FN: Loops through IFYs and adds to file
(defn loop [buffer]
  "Finds and returns the IFY needed to be add when loop isn't skipped"
      (tset file.startify :current-line 1)
      (let [ifys config.opts.render-order
            ifys-length (length ifys)]
        (for [i 1 ifys-length]
          (ify-loop buffer (. ifys i))
          (set file.startify.working-ify
                (+ file.startify.working-ify 1)))))
