package oop.clone;

//no constructor -> time creating off
//final fields problem
class MyObject implements Cloneable{
	int i;
	NewObject newObject;
	
	public MyObject() {
		
	}
	
	public MyObject(MyObject myObject) {
		i = myObject.i;
		//newObject = myObject.newObject;
		newObject = new NewObject(myObject.newObject);
	}
	
	@Override
	protected MyObject clone() throws CloneNotSupportedException {
		MyObject myObject = (MyObject) super.clone();
		myObject.newObject = (NewObject) newObject.clone();
		return myObject;
	}
	
}

class NewObject implements Cloneable{
	int j;

	public NewObject() {
		
	}
	
	public NewObject(NewObject newObject) {
		j = newObject.j;
	}
	
	@Override
	protected NewObject clone() throws CloneNotSupportedException {
		return (NewObject) super.clone();
	}
	
}


public class CloneTest {

	public static void main(String ...ew) throws CloneNotSupportedException {
		C c = new C();
		C c1 = c.clone();
		/*MyObject myObject = new MyObject();
		myObject.i=4;
		NewObject newObject = new NewObject();
		newObject.j = 9;
		myObject.newObject = newObject;
		MyObject clone = myObject.clone();
		clone.i = 77;
		clone.newObject.j =55;
		System.out.println(myObject.newObject.j);*/
	}

}
/*class A implements Cloneable{
	public int i = 10;
	
	@Override
	protected A clone() throws CloneNotSupportedException {
		Object o = super.clone();
		System.out.println(o.getClass());
		return (A) o;
	}
}

class B extends A implements Cloneable {
	public int i = 20;
	
	@Override
	protected B clone() throws CloneNotSupportedException {
		A cloneA = super.clone();
		B cloneB = (B) cloneA;
		System.out.println(cloneB.i+" ");
		return cloneB;
	}
}*/
/* So, as a matter of fact, the clone()method of Object somehow can look down
 *  the call stack and see which type of object at the start of the chain 
 *  invoked clone(), then, provided the calls bubble up so that 
 *  Object#clone()is actually called, an object of that type is created. 
 *  So this happens already in class C, which is strange, but it explains 
 *  why the downcasts do not result in a ClassCastException. I've checked 
 *  with the OpenJDK, and it appears this comes by some Java black magic implemented in native code.*/
class A implements Cloneable 
{
   @Override
   protected A clone() throws CloneNotSupportedException // could be public
   { 
      Object clone = super.clone();
      System.out.println("Class A: " + clone.getClass()); // will print 'C'
      return (A) clone;
   }
}

class B extends A
{
   @Override
   protected B clone() throws CloneNotSupportedException
   { 
      A clone = super.clone();
      System.out.println("Class B: " + clone.getClass()); // will print 'C'
      return (B) clone;
   }
}

class C extends B
{
   @Override
   protected C clone() throws CloneNotSupportedException
   { 
      B clone = super.clone();
      System.out.println("Class C: " + clone.getClass()); // will print 'C'
      return (C) clone;
   }
}

