(defsystem "02_vector"
    :description "Common Lisp implementation of Raytracing in one weekend. Chapter 3."
    :author "Radosław Chmielarz <radoslaw@chmielarz.cc>"
    :license "CC0 1.0 Universal"
    :depends-on (#:let-over-lambda)
    :components ((:file "vec3")
		 (:file "02_vector"))
    :build-operation program-op
    :build-pathname "02_vector"
    :entry-point "02-vector::main")
