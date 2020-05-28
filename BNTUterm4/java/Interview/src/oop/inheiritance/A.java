package oop.inheiritance;

interface I1 {
	final int p = 10;

	public int get();
}

class B implements I1 {
	private int p = 20;
	public int i = 2;

	public int get() {
		return p;
	}
}

class C extends B implements I1 {
	public int i = 3;

	public int get() {
		return p;
	}
}

public class A {
	public static void main(String... ed) {
		B obj = new C();
		System.out.println(obj.get());
		System.out.println(obj.i);
	}

}
