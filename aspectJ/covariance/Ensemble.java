package covariance;

import java.util.ArrayList;

public class Ensemble {
	ArrayList<Element> elements = new ArrayList<Element>();
	
	public Element addElement(Element e) throws Exception{
		elements.add(e);
		e.setParent(this);
		return e;
	}
}
