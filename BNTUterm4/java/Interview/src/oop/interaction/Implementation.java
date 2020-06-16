package oop.interaction;

abstract class Base {
	//Абстрактный класс может содержать protected и static члены, а интерфейс нет.
	// there is no plural inheritance
	int y; // can be not final

	void doSome() {// before java8 it was especially useful. 
		System.out.println("Base");
	}

	
	abstract void work();// Not public
}






interface I1 {// combines hierarchies under one interaction interface
	int x = 3;// public static final
	
	default void doSome() {
		System.out.println("I1");
	}
	
	public void out1();
}

interface I2 {
	int x = 4;// public static final

	default void doSome() {
		System.out.println("I1");
	}
	
	public void out2();
}





class Attempt implements I1, I2 {
	
	private Attempt(){
		
	}
	
	public static Attempt creat() {
		return new Attempt();
	}
	
	public void doSome(){
		System.out.println("Attempt" + I2.x);
		I1.super.doSome();
	}
	
	public void out1() {
		System.out.println("out1");
	}
	
	public void out2() {
		System.out.println("out2");
	}
}







public class Implementation {

	public static void main(String... str) {

		Attempt attempt = Attempt.creat();
		I1 a;
		a = attempt;
		a.out1();
		((I2)a).out2();
	}

}
