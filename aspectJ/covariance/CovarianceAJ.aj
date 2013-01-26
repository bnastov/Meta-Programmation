package covariance;

public aspect CovarianceAJ {
	
	pointcut checkElement(Element element) : 
		(execution(* Ensemble.addElement(Element)) && args(element));
	
	before(Element element) throws Exception : checkElement(element) {
		System.out.println("Add element");
		if(!(thisJoinPoint.getThis() instanceof Ensemble)) 
			throw new Exception("Non compatible type");
		
	}	
	
	pointcut checkListElement(MyListElement listElement) : 
		(execution(* Ensemble.addElement(Element)) && args(listElement));
	
	
	before(MyListElement listElement) throws Exception : checkListElement(listElement) {
		System.out.println("Add ListElement");
		if(!(thisJoinPoint.getThis() instanceof MaListe)
				|| !(listElement instanceof MyListElement)) 
			throw new Exception("Non compatible type");

	}
}
