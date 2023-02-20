(module nvim-startify.utils.highlight)

;;; Module: Handle highlighting

;;; Key/val: highlight groups for specific items
(def groups {:header {:link :Title
                      :name :StartifyHeader}
             :special {:link :Comment
                       :name :StartifySpecial}
             :directory {:link :Directory
                         :name :StartifyFile}})
