(defsystem "02_vector"
  :author "Radoslaw Chmielarz"
  :license "LLGPL"
  :depends-on ()
  :components ((:file "02_vector"))
  :description "Raytracing in one weekend chapter 2"
  :build-operation program-op
  :build-pathname "02_vector"
  :entry-point "02-vector::main")
