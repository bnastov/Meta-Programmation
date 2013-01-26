package test;

import covariance.Element;
import covariance.Ensemble;
import covariance.MaListe;
import covariance.MyListElement;
import memorisation.MemoObject;
import singleton.Singleton;

public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		//Test Singleton
		/*Singleton.getSingleton();
		Singleton.getSingleton();
		Singleton.getSingleton();*/
		
		//Test Memo
		/*MemoObject x = new MemoObject();
		MemoObject y = new MemoObject();
		System.out.println(y.getInstances().size());*/
		
		//Test Covariance
		/*
		Ensemble ens = new Ensemble();
		MaListe ml = new MaListe();
		
		Element el = new Element();
		MyListElement elListe = new MyListElement();
		
		try {
			
			ens.addElement(el);
			ml.addElement(elListe);
			
			//ens.addElement(elListe);
			
			System.out.println(el instanceof MyListElement);
		} catch (Exception e) {e.printStackTrace();}
		
		*/
	}

}
