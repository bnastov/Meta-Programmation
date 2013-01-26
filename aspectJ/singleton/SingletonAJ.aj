package singleton;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;

public aspect SingletonAJ {
	pointcut checkInstance() : 
		(execution(* Singleton.getSingleton()));

	before() : checkInstance() {
		try {
			Field inst = Singleton.class.getDeclaredField("instance");
			inst.setAccessible(true);
			
			if(inst.get(Singleton.class) == null){
				System.out.println("Initialisation de l'instance singleton");
				//Recuperation des constructeurs
				Constructor<?>[] con = Singleton.class.getDeclaredConstructors();
				//Le constructeur est acessible pour qu'on instancie l'instance
				con[0].setAccessible(true);
				inst.set(Singleton.class, (Singleton) con[0].newInstance());
				System.out.println(inst.toString());
				//On n'a plus besoin du constructeur et de l'instance donc visibility -> private
				inst.setAccessible(false);
				con[0].setAccessible(false);
			}
		} 
		catch (InstantiationException e) 	{e.printStackTrace();} 
		catch (IllegalAccessException e)   	{e.printStackTrace();} 
		catch (IllegalArgumentException e) 	{e.printStackTrace();} 
		catch (InvocationTargetException e) {e.printStackTrace();}		
		catch (NoSuchFieldException | SecurityException e) {e.printStackTrace();}			
	}
}
