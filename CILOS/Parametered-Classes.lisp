#| Les classes parametres |#

;MEMO CLASS et OBJECT

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

;MEMO META CLASS et OBJECT

(defclass memo-meta-object(standard-class memo-object)
	()
	(:metaclass standard-class))

(defclass memo-meta-class(memo-class memo-meta-object)
	()
	(:metaclass standard-class))
	
(defmethod validate-superclass((cl memo-meta-class)(scl standard-class))
	(eq 'memo-meta-object 
		(class-name scl)))
	
(defmethod validate-superclass((cl memo-meta-class)(scl memo-meta-class))
	t)
		
;Definiton des classes

(defclass param-class(memo-meta-object)
	((Parameter :initform 'standard-object
				:accessor class-param))
	(:metaclass memo-meta-class))
	
(defclass param-object(standard-object)
	(:meta-class standard-class))
	
;generic
(defgeneric check-param(x y))
(defgeneric make-generic-instance (class type))

;validate superclass	
(defmethod validate-superclass((cl param-class) (scl param-class))
	t)
	
(defmethod validate-superclass((cl standard-class) (scl param-class))
	nil)

(defmethod validate-superclass((cl param-class) (scl standard-class))
	(eq 'param-object (class-name scl)))
	

;La class Stack

(defclass stack-class(param-class)
	()
	(:metaclass memo-meta-class))
	
(defclass stack-object(param-object)
	((Table :initform nil
			:accessor stack-table))
	(:metaclass stack-class))

;Generic

(defgeneric pop-element( x ))
(defgeneric push-element(x y))

;Definitoon de validate-superclass

(defmethod validate-superclass((cl stack-class) (scl standard-class))
	nil)

(defmethod validate-superclass((cl stack-class) (scl stack-class))
	t)

;Conformite de type parametre
(defmethod check-param ((cl param-object) param)
	(typep param (class-param (class-of cl))))

;Push et Pop
(defmethod pop-element((cl stack-object))
	(let ((x (car (stack-table cl))))
		(setf (stack-table cl)
			(delete x (stack-table cl)))
		x))

(defmethod push-element((cl stack-object) element)
	(when (check-param cl element)
		(setf (stack-table cl)
			(cons element (stack-table cl)))
			element))

		
;On test ici
;(setf x (make-instance 'stack-object))
;(setf y (make-instance 'standard-object))
;(push-element x y)
;(stack-table x)
;(pop-element x)
;(stack-table x)

(defclass stack-int(stack-object)
	()
	(:metaclass stack-class))


(defmethod make-generic-instance(class type)
	(let ((x (find class (class-instances (find-class 'param-class)) :key 'class-name)))
		(or (and x (eq (class-param x) type) (make-instance x))
			(let ((y (make-instance 'param-class 
									:name class 
									:direct-superclasses  (cons (find-class 'param-object) ()))))
			(setf (class-param  y) type)
			(make-instance y)))))		

(defmethod make-generic-stack-instance(type)
	(let ((x (find type  (class-instances (find-class 'stack-class)) :key 'class-param)))
		(or (and x (make-instance x))
			(let ((y (make-instance 	'stack-class 
										:name 'stack-class
										:direct-superclasses  (cons (find-class 'stack-object) ()))))
				(setf (class-param  y) type)
				(make-instance y)))))
#|
;test
;une instance d'une classe parametree
(setf x (make-generic-instance 'stack 'int))
;verifions si la classe est enregistree
(class-instances (class-of (class-of x)))
;Result : (#<PARAM-CLASS STACK>)
;La classe est donc enregistree, ajoutons une autre class
(make-generic-instance 'vector 'int)
;verifions si la classe est enregistree
(class-instances (class-of (class-of x)))
;Result : (#<PARAM-CLASS VECTOR> #<PARAM-CLASS STACK>)
(make-instance (class-of x))

|#
				
(defmethod parametric-type-p (instance class type)
	(and (subtypep (class-name (class-of instance)) class)
		 (subtypep (class-param (class-of instance)) type)))
#|
;test
(setf x (make-generic-instance 'stack-class 'integer)
(parametric-type-p x 'stack-class 'integer)
;->True
|#
