(module nvim-startify.session.delete)

;;; Module: handles deletion of sessions

;;; FN: Module initialization
;;; @bang: Boolean -- whether to force deletion
;;; @files: Seq -- file(s) to delete
(defn init [bang files] "Delete sessions
@bang: Boolean -- whether to force deletion
@files: Seq -- file(s) to delete"
      (print "DELETED BUFFERS"))
