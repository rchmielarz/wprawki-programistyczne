(defsystem "03_ray"
    :description "Common Lisp implementation of Raytracing in one weekend. Chapter 4."
    :author "Radosław Chmielarz <radoslaw@chmielarz.cc>"
    :license "CC0 1.0 Universal"
    :depends-on (#:let-over-lambda)
    :components ((:file "vec3")
		 (:file "ray")
		 (:file "03_ray"))
    :build-operation program-op
    :build-pathname "03_ray"
    :entry-point "03-ray::main")
