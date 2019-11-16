(defsystem "01_gradient"
  :description "Common Lisp implementation of Raytracing in one weekend. Chapter 2."
  :author "Radosław Chmielarz <radoslaw@chmielarz.cc>"
  :license "CC0 1.0 Universal"
  :depends-on ()
  :components ((:file "01_gradient"))
  :build-operation program-op
  :build-pathname "01_gradient"
  :entry-point "01-gradient::main")
