package singleton;

public class Singleton {
	
	private static Singleton instance = null;
	
	private Singleton(){}
	
	public static Singleton getSingleton(){
		if(instance != null){
			return instance;
		}
		else{
			instance = new Singleton();
			return instance;
		}
	}
}
