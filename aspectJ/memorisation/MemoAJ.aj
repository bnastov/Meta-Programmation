package memorisation;

public aspect MemoAJ {
	pointcut addInstance() 
		: execution(* MemoObject.MemoObject());
	
	after() returning() : addInstance() {
		System.out.println("ajoutd'instances");		
		MemoObject mo = (MemoObject)thisJoinPoint.getThis();
		mo.getInstances().add(mo);
	}
	
}
