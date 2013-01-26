package memo;

import java.util.ArrayList;

public class A extends MemoObject{
	private static ArrayList<A> instances = new ArrayList<A>();
	
	public ArrayList<? extends A> getInstances() {
		return instances;
	}
}
