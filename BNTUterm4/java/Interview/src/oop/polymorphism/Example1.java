package oop.polymorphism;

class A {
	A(){
		super();
		System.out.println("A");
		a();
	}

	void a() {
		System.out.println("a");
	}
}

class B extends A {
	B(){
		super();
		System.out.println("B");
		a();
	}

	void a() {
		System.out.println("b");
	}
}

public class Example1 {

	public static void main(String ...df) {
		A alpha = new B();
		
		
		System.out.println("\n\n");
		
		
		((A)new B()).a();
	}

}
