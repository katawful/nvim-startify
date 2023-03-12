(module nvim-startify.render.init
        {autoload {file nvim-startify.utils.file
                   buf nvim-startify.utils.buffer
                   iter nvim-startify.render.iterator
                   config nvim-startify.utils.config
                   extmark nvim-startify.utils.extmark
                   index nvim-startify.utils.index}
         require-macros [nvim-startify.katcros-fnl.macros.nvim.api.options.macros
                         nvim-startify.katcros-fnl.macros.nvim.api.utils.macros]})

;;; Module: render out Startify page

;;; FN: Module initialization
;;; @on-vimenter: Boolean -- are we running via 'VimEnter' autocmd
(defn init [on-vimenter] "Initialization of a new startify buffer"
      (print "STARTIFY STARTED")
      ;; NOTE: I don't actually know if I need to check on-vimenter here for any reason
      ;; (if on-vimenter (tset file.startify.buffer (vim.api.nvim_get_current_buf)))

      ;; Add namespace to file.startify.namespace
      (when on-vimenter (extmark.create-namespace))
      (local buffer (vim.api.nvim_create_buf true false))
      (if (and (buf.modifiable? 0)
               (not (buf.visible-modified? 0))
               (not (config.server-skipped?))
               (buf.empty? 0))
        (do (print "STARTIFY  RUN")
          (tset file.startify buffer {})

          ;; We need to track the buffer we are working on
          ;; -- so we don't pass vars between functions all the time
          ;; I don't like this really, but there's no better way
          (tset file.startify :working-buffer buffer)

          ;; Setup buffer
          (vim.api.nvim_win_set_buf 0 buffer)
          (buf.start buffer)

          ;; Need to keep track of the IFYs we are storing to data
          (tset file.startify :working-ify 1)
          (tset (. file.startify buffer) :ify [])
          (tset (. file.startify buffer) :keys [])

          ;; Render to file
          (iter.loop buffer)

          ;; Unmodify buffer when done
          (buf.unmodify buffer)
          (tset file.startify :working-buffer nil)
          (tset file.startify :working-ify nil))
        (do
          (vim.api.nvim_delete_buffer buffer)))
