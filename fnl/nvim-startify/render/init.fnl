(module nvim-startify.render.init
        {autoload {file nvim-startify.utils.file
                   buf nvim-startify.utils.buffer
                   config nvim-startify.utils.config
                   extmark nvim-startify.utils.extmark
                   fortune nvim-startify.fortune.init
                   high nvim-startify.utils.highlight
                   loader nvim-startify.session.loader
                   a nvim-startify.aniseed.core
                   iter nvim-startify.render.iterator}
         require-macros [nvim-startify.katcros-fnl.macros.nvim.api.options.macros
                         nvim-startify.katcros-fnl.macros.nvim.api.utils.macros]})

;;; Module: render out Startify page

;;; Key/val: options of startify buffer
(def startify-opts {:bufhidden :wipe
                    :colorcolumn :0
                    :foldcolumn :0
                    :matchpairs ""
                    :buflisted false
                    :cursorcolumn false
                    :cursorline false
                    :list false
                    :number false
                    :readonly false
                    :relativenumber false
                    :spell false
                    :swapfile false
                    :signcolumn :no})

;;; FN: Set buffer options for startify.
;;; This is currently unclean
;;; @buffer: Number -- represents buffer
(defn set-options [buffer] "Set buffer opts for startify
This isn't particularly clean, but it's needed to set some options properly
@buffer: Number -- represents buffer"
      (each [opt val (pairs startify-opts)]
        (tset vim.opt_local opt val))
      (vim.api.nvim_buf_set_option buffer :synmaxcol
                                   (. (vim.api.nvim_get_option_info :synmaxcol) :default))
      (if (not (vim.api.nvim_win_get_option 0 :statusline))
        (vim.api.nvim_win_set_option 0 :statusline "\\ startify"))
      (tset (. vim.bo buffer) :filetype :startify))

;;; FN: start the startify buffer
;;; @buffer: Number -- represents a buffer
(defn start-buffer [buffer] "start the startify buffer
@buffer: Number -- represents a buffer"
      (set-options buffer)

      ;; Insert an arbitrary amount of blanklines for easier implementation
      (file.insert-blankline buffer 1000))

;;; FN: unmodifies a buffer
;;; @buffer: Number -- represents a buffer
(defn unmodify [buffer] "Unmodify a buffer"
      (vim.api.nvim_buf_set_option buffer :modified false)
      (vim.api.nvim_buf_set_option buffer :modifiable false))

;;; FN: Module initialization
;;; @on-vimenter: Boolean -- are we running via 'VimEnter' autocmd
(defn init [on-vimenter] "Initialization of a new startify buffer"
      (print "STARTIFY STARTED")
      ;; NOTE: I don't actually know if I need to check on-vimenter here for any reason
      ;; (if on-vimenter (tset file.startify.buffer (vim.api.nvim_get_current_buf)))

      ;; Add namespace to file.startify.namespace
      (when on-vimenter (extmark.create-namespace))
      (local buffer (vim.api.nvim_create_buf true false))
      (tset file.startify buffer {})
      (if (and (buf.modifiable? 0)
               (not (buf.visible-modified? 0))
               (not (config.server-skipped?))
               (buf.empty? 0))
        (do (print "STARTIFY  RUN")
          (vim.api.nvim_win_set_buf 0 buffer)
          (start-buffer buffer)

          ;; Unmodify buffer when done
          (unmodify buffer))
        (do
          (vim.api.nvim_delete_buffer buffer)
          (tset file.startify buffer nil))))
