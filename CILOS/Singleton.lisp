#| SINGLETON |#

(defclass singleton-object (standard-object)
  ()
  (:metaclass standard-class))

(defclass singleton-class (standard-class)
  ((instance :accessor class-singleton-instance
	     :initform nil))
  (:metaclass standard-class))

(defmethod make-instance ((in singleton-class) &rest args)
  (or (class-singleton-instance in)
      (let ((x call-next-method))
	(setf (class-singleton-instance in) x)
	x)))

(defmethod validate-superclass ((cl standard-class)
				(sc singleton-class))
  ())

(defmethod validate-superclass ((cl singleton-class)
				(sc standard-class))
  (eq 'singleton-object 
      (class-name sc)))

(defclass A (singleton-object)
  ()
  (:metaclass singleton-class))

(defclass B (A)
  ()
  (:metaclass singleton-class))
; B ne peut pas herité de A!! Alors c'est bon ( objectif accis )
