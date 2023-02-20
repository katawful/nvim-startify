(module nvim-startify.fortune.init
        {autoload {file nvim-startify.utils.file}})

;;; Module: handles fortune generation

;;; FN: Module initialization
(defn init [] "Module initialization"
      ["FORTUNE" "nnnnnnnnnnnnnnnnnnnnnn"])

;;; FN: Find longest line in header
;;; @buffer: Number -- represents a buffer
(defn longest-line [buffer] "Returns the number of characters for the longest header line"
      (var line-count 0)
      (each [_ v (ipairs (file.get-value buffer :header :contents))]
        (if (> (length v) line-count)
          (set line-count (length v))))
      line-count)
