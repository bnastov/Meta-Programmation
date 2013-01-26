package memorisation;

import java.util.ArrayList;
import java.util.Collection;

public class MemoObject {
	private static ArrayList<MemoObject> instances = new ArrayList<MemoObject>();
	
	public MemoObject(){
	}
	
	public ArrayList<MemoObject> getInstances(){
		return instances;
	}
}
