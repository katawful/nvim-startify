(module nvim-startify.utils.data
        {autoload {file nvim-startify.utils.file}})

;;; Module: Handle storing internal data to memory
;;; This is needed to keep track of everything
;;; It is rather complex, but there isn't a way to know what
;;; -- IFY is linked to another

;;; FN: Insert a entry data entry
;;; @entry: Key/val -- data to add to file.startify
(defn insert-entry [entry]
      "Insert a list entry data entry
@entry: Key/val -- data to add to file.startify"
      (table.insert (. (. (. (. file.startify
                                file.startify.working-buffer)
                             :ify)
                          file.startify.working-ify)
                       :entries)
                    entry))

;;; FN: Insert a key data entry
;;; This is for a list IFY
;;; The keys table will duplicate for ease of use
;;; @entry: Key/val -- data to add to file.startify
;;; @index: The current entry index
(defn insert-key [entry index]
      "Insert a key data entry
This is for a list IFY
The keys table will duplicate for ease of use
@entry: Key/val -- data to add to file.startify
@index: The current entry index"
      (table.insert (. (. (. (. file.startify
                                file.startify.working-buffer)
                             :ify)
                          file.startify.working-ify)
                       :keys)
                    entry)
      (tset entry :index index)
      (table.insert (. (. file.startify file.startify.working-buffer) :keys)
                    entry))

;;; FN: Set a value for a IFY
;;; @ify: The index of the ify in use
;;; @key: The key to add
;;; @value: The value to add
(defn set-ify-value [ify key value]
      (tset (. (. (. file.startify file.startify.working-buffer)
                  :ify)
               ify)
            key value))

;;; FN: Get a value for a IFY
;;; @ify: The index of the ify in use
;;; @key: The key to add
(defn get-ify-value [ify key]
      (. (. (. (. file.startify file.startify.working-buffer)
               :ify)
           ify)
         key))

;;; FN: Insert a entry for a IFY
;;; @entry: Key/val -- The entry to add
(defn insert-ify-entry [entry]
      (table.insert (. (. file.startify file.startify.working-buffer)
                       :ify)
                    entry))

;;; FN: Insert a extmark for a IFY
;;; @entry: Key/val -- The entry to add
(defn insert-ify-extmark [ext]
      (when (not (. (. (. (. file.startify file.startify.working-buffer)
                          :ify)
                       file.startify.working-ify)
                    :ext))
        (tset  (. (. (. file.startify file.startify.working-buffer)
                     :ify)
                  file.startify.working-ify)
              :ext []))
      (table.insert (. (. (. (. file.startify file.startify.working-buffer)
                             :ify)
                         file.startify.working-ify)
                       :ext)
                    ext))

;;; FN: Increment current line
;;; @amount: Number -- amount to inc by
(defn inc-cur-line [amount]
      (set file.startify.current-line (+ file.startify.current-line amount)))
