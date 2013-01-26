(defclass personne(standard-object)
	((nom 	:initform 'nastov
			:initarg :nom
			:accessor personne-nom)
	(prenom	:initform 'blazo
			:initarg :prenom
			:accessor personne-prenom)
	(adresse :accessor personne-adress))
	(:metaclass standard-class))

(defun inspect-object (( object standard-object))
  (inspect-instance (class-slots (class-of object)) object) )


(defun inspect-instance (slots o)
  ( if(atom slots) 
		()
		(cons 	(inspect-slot (car slots) o)
				(inspect-instance (cdr slots) o)))) 

			
(defun inspect-slot(slot o)
	(let ((slot-name (slot-definition-name slot)))
		(let	((slot-valeur (if(slot-boundp o slot-name)
								(slot-value o slot-name)
								'non-initialized)))
		(list slot-name '=> slot-valeur))))

;test		
;(setf x (make-instance 'personne))
;(inspect-object x)
;affiche bien nom => nastov prenom => blazo 
;et pour le slot non-initialise adress => non-initialized 
  