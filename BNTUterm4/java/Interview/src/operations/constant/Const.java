package operations.constant;



public class Const {
	
	static byte m1() {
		final int i = 23;
		return i;
	}

	static byte m2(final int i) {
		return (byte) i;
	}
	
	byte mmf() {return 127;}

	public static void main(String... ew) {
		
	}
	
}





interface Op{
	static int r =3;//final static
	int re =3;//final static
	
}

abstract class A{
	int a =8;

	A(){
		System.out.println("before show");
		show();
		System.out.println("after show");
	}
	abstract void show();
}
class B extends A{
	int a = 90;
	void show() {
		System.out.println(a);
	}
}


