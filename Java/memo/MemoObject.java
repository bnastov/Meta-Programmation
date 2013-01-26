package memo;

import java.util.ArrayList;
import java.util.Collection;

public class MemoObject {
	private static ArrayList<MemoObject> instances = new ArrayList<MemoObject>();
	
	public MemoObject(){
		((ArrayList<MemoObject>)  getInstance()).add(this);
	}
	
	public ArrayList<? extends MemoObject> getInstance(){
		return instances;
	}
}
