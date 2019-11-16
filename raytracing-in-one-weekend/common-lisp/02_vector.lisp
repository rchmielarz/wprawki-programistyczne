(defpackage 02-vector
  (:use :cl :vec3))

(in-package :02-vector)

(defparameter *x* 200)
(defparameter *y* 100)
(defparameter *output* "02_vector.ppm")

(defun main ()
  (with-open-file (out *output* :direction :output :if-exists :supersede)
    (format out "P3~%~D ~D~%255~%" *x* *y*)
    (loop for j downfrom (- *y* 1) to 0 do
	 (loop for i from 0 below *x* do
	      (let* ((col (make-vec3 :r (/ i *x*) :g (/ j *y*) :b 0.2))
		     (ir (floor (* 255.99 (r col))))
		     (ig (floor (* 255.99 (g col))))
		     (ib (floor (* 255.99 (b col)))))
		(format out "~D ~D ~D~%" ir ig ib))))))
