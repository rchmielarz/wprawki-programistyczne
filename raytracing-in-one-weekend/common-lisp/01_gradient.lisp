(in-package :raytracing-in-one-weekend)

(defparameter *x* 200)
(defparameter *y* 100)
(defparameter *output* "01_gradient.ppm")

(defun main ()
  (with-open-file (out *output* :direction :output :if-exists :supersede)
    (format out "P3~%~D ~D~%255~%" *x* *y*)
    (loop for j from (- *y* 1) downto 0 do
	 (loop for i from 0 to (- *x* 1) do
	      (let* ((r (/ i *x*))
		     (g (/ j *y*))
		     (b 0.2)
		     (ir (floor (* 255.99 r)))
		     (ig (floor (* 255.99 g)))
		     (ib (floor (* 255.99 b))))
		(format out "~D ~D ~D~%" ir ig ib))))))
