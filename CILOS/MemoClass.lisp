#| MEMO CLASS |#

(defclass memo-object ( standard-object )
  ()
  (:metaclass standard-class))

(defclass memo-class ( standard-class )
  ((EnsInstances :initform nil
		 :accessor class-instances))
  (:metaclass standard-class))

(defgeneric free-object ( x ))
(defgeneric free-instance ( x y ))

(defmethod make-instance ((mc memo-class) &rest args)
  (let ((x (call-next-method)))
    (setf (class-instances mc)
	  (cons x (class-instances mc)))
    x))

(defmethod validate-superclass ((cl memo-class) (sup standard-class))
   (eq 'memo-object (class-name sup)))
 
(defmethod validate-superclass ((cl memo-class) (sup memo-class))
   t)
 
(defmethod validate-superclass ((cl standard-class) (sup memo-class))
   ())
 
(defmethod free-instance (( mc memo-class) out)
   (setf (class-instances mc)
 	(delete out (class-instances mc))))
(defmethod free-object (( mo memo-object))
   (free-instance (class-of mo) mo))
 
 
(defclass polygon (memo-object)
   ((list-angles :initarg :angles
 		:accessor poly-angles)
    (list-sides :initarg :sides
 	       :accessor poly-sides)
    (side-nb :accessor poly-nb)
    (angles-sum :accessor poly-angles-sum))
   (:metaclass memo-class)
)
 
(defmethod initialize-instance ((p polygon) &rest initargs)
   (call-next-method)
   (when (and (slot-boundp p 'list-sides)
 	     (slot-boundp p 'list-angles)
 	     (not (= (length (poly-sides p)) 
 		     (length (poly-angles p)))))
     (warn "mauvais nombre de cotes et d'angles : ~s" p)))


