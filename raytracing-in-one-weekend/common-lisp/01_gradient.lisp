(defpackage 01-gradient
  (:use :cl))
(in-package :01-gradient)

(defparameter *x* 200)
(defparameter *y* 100)
(defparameter *output* "01_gradient.ppm")

(defun main ()
  (with-open-file (out *output* :direction :output :if-exists :supersede)
    (format out "P3~%~D ~D~%255~%" *x* *y*)
    (loop for j downfrom (- *y* 1) to 0 do
	 (loop for i from 0 below *x* do
	      (let* ((r (/ i *x*))
		     (g (/ j *y*))
		     (b 0.2)
		     (ir (floor (* 255.99 r)))
		     (ig (floor (* 255.99 g)))
		     (ib (floor (* 255.99 b))))
		(format out "~D ~D ~D~%" ir ig ib))))))
