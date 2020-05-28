package enumTest;

class Sub extends Base{
	{
		System.out.println("sub din");
	}
}

public abstract class Base {

	static Sub one = new Sub();
	
	static Sub two = new Sub();
	static {
		System.out.println("base static1");
	}
	static Sub three = new Sub();
	
	public Base() {
		System.out.println("base constr");
	}
	{
	System.out.println("base din");
	}
	static {
		System.out.println("base static2");
	}
	public static void main (String ...dgfd){
		Base b;
	}
}
