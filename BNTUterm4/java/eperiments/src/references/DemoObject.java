package references;

public class DemoObject{
	//object.hashCode(); cheks references
	public static void main(String [] ijo) {
		Object o1 = new Object();
		Object o2 = o1;
		System.out.println(o1.hashCode()+"       "+ o2.hashCode());
		System.out.println(o1.toString()+"       "+ o2.toString());

		System.out.println(o1.getClass()+"       "+ o2.getClass());
		
	}
}