(module nvim-startify.session.write)

;;; Module: Session writing

;;; FN: Module initialization
;;; @file: String -- file to write
(defn init [file] "Initialization
@file: String -- file to write"
      (print "SESSION WRITTEN"))

;;; FN: Save a session to file
;;; @bang: Boolean -- whether to force the write
;;; @files: Seq -- files to write
(defn save [bang files] "Save session to file
@bang: Boolean -- whether to force the write
@files: Seq -- files to write"
      (print "SESSION WRITTEN"))
