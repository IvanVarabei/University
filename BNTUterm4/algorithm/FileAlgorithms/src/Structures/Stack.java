package Structures;

public class Stack {

	Node head;

	class Node {
		Node next;
		Object content;

		Node(Object o) {
			content = o;
		}
	}

	void push(Object o) {
		if (head == null) {
			head = new Node(o);
		} else {
			getTail().next = new Node(o);
		}
	}

	Object pop() {
		Object content = null;
		Node temp = head, prev = head;
		while (head!=null) {
			if (temp.next == null) {
				content = temp.content;
				if(prev == temp) {
					head = null;
					break;
				}
				prev.next = null;
				break;
			}
			prev = temp;
			temp = temp.next;		
		}
		return content;
	}
	
	Node getTail() {
		Node temp = head;
		while (temp.next != null) {
			temp = temp.next;
		}
		return temp;
	}
	
	Node getPenultimateBeforeTail() {
		Node temp = head;
		while (temp.next.next != null) {
			temp = temp.next;
		}
		return temp;
	}
	
	int sum() {
		int sum = 0;
		Node temp = head;
		try {
		while(temp!=null) {
			sum += Integer.parseInt(temp.content.toString());
			temp=temp.next;
		}	
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return sum;
	}

	public static void main(String... dfsg) {
		Stack st = new Stack();
		st.push("1");
		st.push("2");
		st.push("3");
		st.push("4");
		st.push("5");
		System.out.println(st.sum());
		System.out.println(st.pop());
		System.out.println(st.pop());
		System.out.println(st.pop());
		System.out.println(st.pop());
		System.out.println(st.pop());
		System.out.println(st.pop());
		System.out.println(st.pop());
	}
}
