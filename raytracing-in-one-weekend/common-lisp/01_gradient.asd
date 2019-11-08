(defsystem "01_gradient"
  :author "Radoslaw Chmielarz"
  :license "LLGPL"
  :depends-on ()
  :components ((:file "01_gradient"))
  :description "Raytracing in one weekend chapter 1"
  :build-operation program-op
  :build-pathname "01_gradient"
  :entry-point "01-gradient::main")
