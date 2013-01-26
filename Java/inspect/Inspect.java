package inspect;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.Scanner;

public class Inspect {
	
	
	public static void startInspection(Object o){
		int enteredValue;
		Scanner sc = new Scanner(System.in);
		inspectObject(o);
		Boolean test = true;
		do{
			System.out.println("Taper le numero d'attribut que vous voulez inspecter - 0 pour terminer");
			enteredValue = sc.nextInt();
			if(enteredValue == 0){
				test = false;
			}
			else{
				Field[] attributs = o.getClass().getFields();
				if(attributs.length < enteredValue){
					System.out.println("Le numero n'est pas valude, veuiller resseyer svp");
				}
				else{
				
					try {
						inspectObject(attributs[enteredValue - 1].get(o));
						
					} catch (IllegalArgumentException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IllegalAccessException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		
		}while(test);
	}
	
	public static void inspectObject(Object o){
		String result = "******************************************\n" +
						"**********Inspecteru d'objects************\n" +
						"******************************************\n" +
						inspectClass(o.getClass()) +  "\n" + 
						inspectAttributes(o.getClass(), o);
		
		System.out.println(result);
	}
	
	/**
	 * This method inspects the class name of the object passed on parameter,
	 * i.e. the name of the class that instantiated the object
	 * The object that will be inspected
	 * @return The result of the inspection in {@link String}
	 */
	private static String inspectClass(Class c){

		
		String result = "******************************************\n" +
						"***********Inspection la Class************\n" +
						"******************************************\n" +
						"Class name : " + c.getName() + "\n" +
						"Superclass name : " + c.getSuperclass().getName() + "\n" +
						"******************************************\n" +
						"La classe implements " + c.getInterfaces().length + "interfaces" +"\n";
		for (Class x : c.getInterfaces()) {
			result += inspectInterface(x);
		}
		result += 	"******************************************\n" +
					"Package : " + c.getPackage().getName() + "\n" +
					"******************************************\n";
		result += inspectsMethods(c);
	    return result;
	}
	
	private static String inspectInterface(Class c) {
		return "interface name : " + c.getName() + "\n";
	}
	
	/**
	 * This method is used to inspects the attributes of an object.
	 * Will inspect the number of parameters, the name, the type of
	 * each attribute.
	 * @param c The class that will be inspected
	 * @return The result of the inspection in {@link String}
	 */
	private static String inspectAttributes(Class c, Object o){
		Field [] attributs = c.getDeclaredFields();
		String result = "******************************************\n" +
						"*********Inspection d'attriibuts**********\n" +
						"Que les attributs public peuvent etre inspecter\n" +
						"******************************************\n" +
						"Nombre d'attributs : " + attributs.length + "\n" +
						"******************************************\n";
		for(int i = 0 ; i < attributs.length ; i++){
			result += inspectAttribute(attributs[i], o);
		}
		return result;
	}
	
	/**
	 * This method is used to inspect the type and the name of an attribute.
	 * @param m The attribute for inspection
	 * @return The result of the inspection in {@link String}
	 */
	private static String inspectAttribute(Field attribute, Object o){
		String result =  "******************************************\n";
		result += "attribute name  : " + attribute.getName() + "\n";
		result += "attribute type  : " + attribute.getType().getName() + "\n";
		try {
			result += "attribute value : " + attribute.get(o) + "\n";
//			
//			if(attribute.isAccessible())
//				result += "attribute value : " + attribute.get(o) + "\n";
//			else
//				result += "attribute value : non acessible \n";
		} 
		catch (IllegalArgumentException e) {e.printStackTrace();} 
		catch (IllegalAccessException e) {e.printStackTrace();}
		result +=  "******************************************\n";
		return result;
	}
	
	/**
	 * This method is used to inspects the methods of an object.
	 * Will inspect the return type, the number of parameters and
	 * each parameter type.
	 * @param o The object that will be inspected
	 * @return The result of the inspection in {@link String}
	 */
	private static String inspectsMethods(Class c){
		Method[] methods = c.getDeclaredMethods();
		String result = "******************************************\n" +
						"**********Inspection de methods***********\n" +
						"******************************************\n" +
						"Nombre de methodes : " + methods.length + "\n" +
						"******************************************\n";
		
		for (Method method : c.getMethods()) {
			result += inspectMethod(method);
		}
		return result;
	}
	
	/**
	 * This method is used to inspect the parameters type of a function,
	 * returning the number of parameters and the type of each parameter.
	 * @param m The method for inspection
	 * @return The result of the inspection in {@link String}
	 */
	private static String inspectMethod(Method m){		
		Class[] params = m.getParameterTypes();		
		String result = "******************************************\n" +
						"Method name : " + m.getName() + "\n" + 
						"Return type : " + m.getReturnType().getName() + "\n" + 
						params.length + " parametres en total\n";
		for (int i = 0 ; i < params.length ; i++) {
			result += "parametre " + (i+1) +" est de type : "  + 
							params[i].getName() + "\n";
		}
		result += "******************************************\n";
		return result;
	}
	
}
