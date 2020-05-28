package Structures;


public class MyList {
	
	static class Node {
		private Node next;
		private Object data;
		private int index;

		public Node(Object data, int index) {
			this.data = data;
			this.index = index;
		}
	}

	private Node head;

	public void add(Object data) {
		if (head == null) {
			head = new Node(data, 0);
			return;
		}
		tail().next = new Node(data, tail().index + 1);
	}
	
	private Node tail() {
		Node tail = head;
		while (tail.next != null) {
			tail = tail.next;
		}
		return tail;
	}

	public void addAll(MyList b) {
		for (int i = 0; i < b.size(); i++) {
			this.add(b.get(i));
		}
	}

	public void remove(int i) {
		if(i == 0) {
			head = head.next;
			Node c = head;
			while (c != null) {
				c.index--;
				c = c.next;
			}
			return;
		}
		if(i == tail().index) {
			Node p = head;
			while (p != null) {
				if(p.next.index == i) {
					p.next = null;
				}
				p = p.next;
			}
			return;
		}
		else {
			Node cur = head;
			Node prev = head;
			while (cur.next != null) {
				if (cur.index == i) {
					prev.next = cur.next;
					while(cur != null) {
						cur.index--;
						cur = cur.next;
					}
					break;
				}
				prev = cur;
				cur = cur.next;

			}
		}
	}
	

	public Object get(int n) {
		Node fast = head;
		while (fast.next != null) {
			if (fast.index == n) {
				break;
			}
			fast = fast.next;
		}
		return fast.data;
	}

	public int size() {
		int length = 0;
		Node current = head;

		while (current != null) {
			length++;
			current = current.next;
		}
		return length;
	}
	
	public void set(int index, Object elem) {
		Node tail = head;
		while (tail != null) {		
			if(tail.index == index) {
				tail.data = elem;
				break;
		}
			tail = tail.next;
		}
	}
	
	void shift(int k) {
		Object[] ms = new Object[size()];
		for(int i = size()-k, j =0; i<size(); i++, j++) {
			ms[j] = get(i);
		}
		for(int i = k, j = 0; i<size(); i++, j++) {
			ms[i] = get(j);
		}
		for(int i =0 ; i< size(); i++) {
			set(i,ms[i]);
		}
	}
	
	public static void main(String ...sdfg) {
		MyList ml = new MyList();
		ml.add(1);
		ml.add(2);
		ml.add(3);
		ml.add(4);
		ml.add(5);
		for(int i = 0; i < ml.size(); i++) {
			System.out.println(ml.get(i).toString());
		}
		System.out.println();
		ml.shift(2);
		for(int i = 0; i < ml.size(); i++) {
			System.out.println(ml.get(i).toString());
		}
		
	}

}
