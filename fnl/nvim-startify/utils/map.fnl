(module nvim-startify.utils.map
        {autoload {buffer nvim-startify.utils.buffer}
         require-macros [nvim-startify.katcros-fnl.macros.nvim.api.maps.macros]})

;;; Module: set mappings

(defn init [] "Set global keymaps"
      (nno- "<plug>(startify-open-buffers)" buffer.open))
