(module nvim-startify.utils.session.loader)

;;; Module: loads in user session files

;;; FN: Module intialization
;;; @source-last-session?: Boolean -- is last session loaded
;;; @files: Seq -- files to load
(defn init [source-last-session? files] "Module intialization
@source-last-session?: Boolean -- is last session loaded
@files: Seq -- files to load"
      (print "SESSION LOADED"))

;;; FN: Load a specific session file
;;; @session-file: String -- session file to load
(defn file [session-file] "Loads a specific session file
deleting all buffers in the process
@session-file: String -- session file to load"
      (print "SESSION LOADED"))
