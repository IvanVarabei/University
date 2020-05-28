package colection;

import java.util.*;

public class ListTest {

	public static void main(String ...ds) {
		List arrayList = new ArrayList<Foot>();
		List linkedList = new LinkedList();
		Vector vector = new Vector();
		Stack<Foot> stack = new Stack();
		
		stack.push(null);
		stack.add(new Foot(2));
		stack.push(new Foot(3));
		stack.push(new Foot(4));
		stack.add(new Foot(5));
		stack.add(new Foot(6));
		
		for(int i =0; i< stack.size(); i++) {
			//System.out.println(stack.peek());
			//i--;
		}
		System.out.println();
		for(Foot f : stack) {
			System.out.println(f);
		}
	}

}
