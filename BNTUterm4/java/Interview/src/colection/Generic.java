package colection;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.*;

public class Generic {
	
	private class O {
	}

	private class A {
	}

	private class B extends A {
	}

	private class B1 extends A {
	}

	private class C extends B {
	}

	
	/*public static <T> T getFirst(List<? super T> list) {
		return list.get(0);//writeonly
	}*/
	public static void main(String ...ds) {
		List ages = new ArrayList();
		ages.add(2);
		ages.add("f");
		for(int i =0; i<ages.size();i++) {
			System.out.println(ages.get(i));
		}
		
		
		String[] strings = new String[] {"a","b","c"};
		Object[] arr = strings;
		//we can't check it on compilation
		arr[0]=2;//ArrayStoreException
		
		List<Integer> ints = Arrays.asList(1,2,3);//не является ни чьим подтипом, только свой собственный
		//List<Number> nums = ints;//compile error
		
		List<Integer> ints1 = new ArrayList<Integer>();
		List<? extends Number> nums1 = ints1;
		
		List<Number> nums2 = new ArrayList<Number>();
		List<? super Integer> ints2 = nums2;
		
		List<Integer> ints3 = new ArrayList<Integer>();
		ints3.add(1);
		ints3.add(2);
		List<? extends Number> nums3 = ints3;
		//nums3.add(5);//only null, readonly
		  
		
		
		
		Generic g = new Generic();
		 ArrayList<A> listA =  new ArrayList<>(
				 Arrays.asList(g.new A(),g.new A(),g.new A()));
		 
		 LinkedList<B> listB = new LinkedList<>(
				 Arrays.asList(g.new B(),g.new B(),g.new B()));
		 
		 java.util.List<B1> vectB1 = new Vector<>(
				 Arrays.asList(g.new B1(),g.new B1(),g.new B1()));
		 
		 java.util.List<C> vectC = new Vector<>(
				 Arrays.asList(g.new C(),g.new C(),g.new C()));
		 
		 java.util.List<O> vectO = new Vector<>(
				 Arrays.asList(g.new O(),g.new O(),g.new O()));
		 
		 printList(listA);
		 printList(listB);
		 printList(vectB1);
		 printList(vectC);
		 //printList(vectO);
 
	}

	static void printList(java.util.List<? extends A > l) {
		for(A abst : l) {
			System.out.println(abst.toString());
		}
		System.out.println();
	}

}
