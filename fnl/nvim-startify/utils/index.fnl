(module nvim-startify.utils.index
        {autoload {config nvim-startify.utils.config
                   file nvim-startify.utils.file}})

;;; Module: handle indices for keymappings

;;; From file.startify[b]global-index-state
;;; This is an indeterminate value
;;; It is stored in the first index of the seq table

;;; From file.startify[b]global-index-position
;;; Mutable Number: stored inside a seq for mutability
;;; This stores the raw value we need to get from the index
;;; This **does not** actually get displayed
;;; This is 1-indexed

;;; FN: create the global-index-state and global-index-position
;;; @buffer: Number -- represents a buffer
(defn create [buffer]
      (if config.opts.custom-index
          (do
            (tset (. file.startify buffer) :global-index-state [])
            (tset (. file.startify buffer) :global-index-position [])
            (tset (. (. file.startify buffer) :global-index-state) 1
                  (. config.opts.custom-index 1))
            (tset (. (. file.startify buffer) :global-index-position) 1 1))
          (do
            (tset (. file.startify buffer) :global-index-state [])
            (tset (. file.startify buffer) :global-index-position [])
            (tset (. (. file.startify buffer) :global-index-state) 1 0)
            (tset (. (. file.startify buffer) :global-index-position) 1 1))))

;;; FN: Increment to a new index and return the current index
;;; This is a weird way to do this, but to maintain state cleanly
;;; - we need to be able to couple the usage with the index state
;;; There is potential to expand this outward for better clarity
;;; If the current index state is needed, one can get the value
;;; - from file.startify[buffer]global-index-state instead
;;; @buffer: Number -- represents a buffer
(defn inc-and-return [buffer]
      (let [pre-cur-index (file.get-value buffer :global-index-state 1)
            cur-index (if pre-cur-index pre-cur-index 0)
            pre-cur-pos (file.get-value buffer :global-index-position 1)
            cur-pos (if pre-cur-pos pre-cur-pos 1)
            next-pos (+ cur-pos 1)]
        (tset (. (. file.startify buffer) :global-index-position) 1 next-pos)
        (if config.opts.custom-index
          (tset (. (. file.startify buffer) :global-index-state) 1
                (. config.opts.custom-index next-pos))
          (tset (. (. file.startify buffer) :global-index-state) 1 cur-pos))
        cur-index))

;;; FN: get the next global index for keymaps
;;; This function will grep global-index-state for the current one
;;; When this is nil, it will need to check config.opts.custom-index
;;; If that is nil then this will start from 0 and index by 1
;;; @buffer: Number -- represents a buffer
(defn get-next [buffer]
      ;; make sure there's a state and continue it
      (if (?. (?. (. file.startify buffer) :global-index-state) 1)
        ;; get next index (doesn't matter if custom)
        (do (inc-and-return buffer))
        ;; gotta create the index and return the first index
        (do (create buffer)
            (inc-and-return buffer))))

