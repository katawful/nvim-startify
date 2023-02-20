(module nvim-startify.render.iterator
        {autoload {file nvim-startify.utils.file}})

;;; Module: Implements buffer iterator that places groups down with
;;; each pass of the iterator. It works through every line of the file,
;;; adding the needed groups at the appropriate lines

;;; FN: Walk through a buffer
;;; @buffer: Number -- represents a buffer
(defn loop [buffer]
  "Walk through buffer
@buffer: Number -- represents a buffer"
      (let [buf-length (length (vim.api.nvim_buf_get_lines buffer
                                                           0 -1
                                                           false))]
        (tset file.startify :current-line 0)
        (var eof false)
        (for [i 1 buf-length :until eof]
          (print i)
          (set eof true))))

;;; FN: Should we skip line?
;;; Returns true if yes
(defn skip-line? []
  "Returns true if we can skip a line and continue looping")

;;; FN: Finds group to add
;;; Returns group to add
(defn group-to-add []
  "Finds and returns the group needed to be add when loop isn't skipped")

;;; FN: Loop through a group
(defn group-loop []
  "Loop through a group")
