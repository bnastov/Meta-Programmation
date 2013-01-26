package test;

import java.util.ArrayList;

import memo.A;
import inspect.Inspect;;

public class Test implements testInspection1, testInspection2{
	public String attribute1 = "Blazo Nastov";
	public int attribute2;
	public char attribure3;
	public Test2 attribute4 = new Test2();
	
	
	public void methode1(){}
	
	public String methode2(String x){
		return x;
	}
	
	public int method3(int a, String b){
		return b.length();
	}
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return super.toString();
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Test x = new Test();
		//Inspect.inspectObject(x);
		Inspect.startInspection(x);
		//A a = new A();
		//A b = new A();
		//System.out.println(a.getInstance().size());
	}

}
