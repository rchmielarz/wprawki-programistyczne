(defpackage vec3
  (:use :cl)
  (:export #:make-vec3
	   #:squared-length
	   #:len
	   #:add
	   #:mul
	   #:make-unit-vector
	   #:sub
	   #:div
	   #:dot
	   #:cross
	   #:unit-vector
	   #:r
	   #:g
	   #:b))

(in-package :vec3)

(defclass vec3 ()
  ((x :initarg :x :accessor x)
   (y :initarg :y :accessor y)
   (z :initarg :z :accessor z)
   (r :initarg :r :accessor r)
   (g :initarg :g :accessor g)
   (b :initarg :b :accessor b)))

(defun make-vec3 (&key x y z r g b)
  (make-instance 'vec3 :x x :y y :z z :r r :g g :b b))

(defgeneric squared-length (vector))

(defmethod squared-length ((vector vec3))
  (+ (* (r vector) (r vector))
     (* (g vector) (g vector))
     (* (b vector) (b vector))))

(defgeneric len (vector))

(defmethod len ((vector vec3))
  (sqrt (squared-length vector)))

(defgeneric add (left right))

(defmethod add ((left vec3) (right vec3))
  (make-vec3 :r (+ (r left) (r right))
	     :g (+ (g left) (g right))
	     :b (+ (b left) (b right))))

(defgeneric mul (left right))

(defmethod mul ((left vec3) (right vec3))
  (make-vec3 :r (* (r left) (r right))
	     :g (* (g left) (g right))
	     :b (* (b left) (b right))))

(defmethod mul ((left vec3) right)
  (make-vec3 :r (* (r left) right)
	     :g (* (g left) right)
	     :b (* (b left) right)))

(defmethod mul (left (right vec3))
    (mul right left))

(defgeneric make-unit-vector (vector))

(defmethod make-unit-vector ((vector vec3))
  (let ((k (/ 1 (squared-length vector))))
    (make-vec3 :r (* (r vector) 2)
	       :g (* (g vector) 2)
	       :b (* (b vector) 2))))

(defgeneric sub (left right))

(defmethod sub ((left vec3) (right vec3))
  (make-vec3 :r (- (r left) (r right))
	     :g (- (g left) (g right))
	     :b (- (b left) (b right))))

(defgeneric div (left right))

(defmethod div ((left vec3) (right vec3))
  (make-vec3 :r (/ (r left) (r right))
	     :g (/ (g left) (g right))
	     :b (/ (b left) (b right))))

(defmethod div ((left vec3) right)
  (make-vec3 :r (/ (r left) right)
	     :g (/ (g left) right)
	     :b (/ (b left) right)))

(defgeneric dot (left right))

(defmethod dot ((left vec3) (right vec3))
  (+ (* (r left) (r right))
     (* (g left) (g right))
     (* (b left) (b right))))

(defgeneric cross (left right))

(defmethod cross ((left vec3) (right vec3))
  (make-vec3 :r (- (* (g left) (b right)) (* (b left) (g right)))
	     :g (- (* (b left) (r right)) (* (r left) (b right)))
	     :b (- (* (r left) (g right)) (* (g left) (r right)))))

(defgeneric unit-vector (vector))

(defmethod unit-vector ((vector vec3))
  (div vector (len vector)))
