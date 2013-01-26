package singleton;

public class Singleton {
	
	private static Singleton instance = null;
	
	private Singleton(){}
	
	public static Singleton getSingleton(){
		return instance;
	}
}
