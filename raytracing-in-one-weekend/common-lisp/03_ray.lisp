(defpackage 03-ray
  (:use :cl
	:vec3
	:ray))

(in-package :03-ray)

(defgeneric color (r))

(defmethod color ((r ray))
  (let* ((unit-direction (unit-vector (direction r)))
	 (u (* 0.5 (+ (g unit-direction) 1))))
    (add (mul (- 1 u)
	      (make-vec3 :r 1 :g 1 :b 1))
       (mul u
	    (make-vec3 :r 0.5 :g 0.7 :b 1)))))

(defparameter *x* 200)
(defparameter *y* 100)
(defparameter *output* "03_ray.ppm")

(defun main ()
  (with-open-file (out *output* :direction :output :if-exists :supersede)
    (format out "P3~%~D ~D~%255~%" *x* *y*)
    (let ((lower-left-corner (make-vec3 :r -2 :g -1 :b -1))
	  (horizontal (make-vec3 :r 4 :g 0 :b 0))
	  (vertical (make-vec3 :r 0 :g 2 :b 0))
	  (origin (make-vec3 :r 0 :g 0 :b 0)))
      (loop for j downfrom (- *y* 1) to 0 do
	   (loop for i from 0 below *x* do
		(let* ((u (/ i *x*))
		       (v (/ j *y*))
		       (r (make-ray :A origin
				    :B (add (add lower-left-corner
						 (mul u horizontal))
					    (mul v vertical))))
		       (col (color r))
		       (ir (floor (* 255.99 (r col))))
		       (ig (floor (* 255.99 (g col))))
		       (ib (floor (* 255.99 (b col)))))
		  (format out "~D ~D ~D~%" ir ig ib)))))))
