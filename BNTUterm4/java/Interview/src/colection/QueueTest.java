package colection;
import java.util.*;

public class QueueTest {

	public static void main(String ...ds) {
		@SuppressWarnings("unchecked")
		Queue priorityQueue = new PriorityQueue(new Comparator() {//can't contain a null
			@Override
			public int compare(Object r, Object l) {
				return ((Foot)r).Field - ((Foot)l).Field;
				
			}
		});
		ArrayDeque arrayDeque = new ArrayDeque();//can't contain a null
		Deque dequeList  = new LinkedList();
		
		Queue linkedList  = new LinkedList();
		Queue queueList  = new LinkedList();
		
		priorityQueue.add(new Foot(1));
		priorityQueue.add(new Foot(2));
		priorityQueue.add(null);
		priorityQueue.add(new Foot(4));
		priorityQueue.offer(new Foot(4));
		priorityQueue.offer(new Foot(4));
		priorityQueue.offer(new Foot(3));
		priorityQueue.offer(new Foot(1));

		System.out.println("Size = " + priorityQueue.size());
		for(int i =0 ; i< priorityQueue.size();i++) {
			System.out.println(priorityQueue.poll());
			i--;
		}
		
		System.out.println();
		//priorityQueue.forEach(j -> System.out.println(j));
	}

}


