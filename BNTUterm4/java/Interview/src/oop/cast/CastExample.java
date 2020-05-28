package oop.cast;

class A{
	
}
class B extends A{
	
}

class C extends B{
	
}

public class CastExample {

	public static void main(String ...r) {
		A a = new A();
		B b = new B();
		C c = new C();
		
		A a1 = c; //UP CAST
		A a2 = (B) c;//UP CAST & DOWN CAST
		C c1 = (C) a;//DOWN CAST clssCast Exeption
		C c2 = (C) b;//DOWN CAST clssCast Exeption
		
	}

}
