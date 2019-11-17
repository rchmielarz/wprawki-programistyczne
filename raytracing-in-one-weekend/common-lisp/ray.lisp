(defpackage ray
  (:use :cl)
  (:export #:ray
	   #:make-ray
	   #:orign
	   #:direction
	   #:point-at-parameter))

(in-package :ray)

(defclass ray ()
  ((A :initarg :A :accessor origin)
   (B :initarg :B :accessor direction)))

(defun make-ray (&key A B)
  (make-instance 'ray :A A :B B))

(defgeneric point-at-parameter (r u))

(defmethod point-at-parameter ((r ray) u)
  (+ (origin r)
     (* (direction r) u)))
