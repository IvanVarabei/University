package Structures;

public class Tree {

	class Node {
		char value;
		Node more;
		Node less;

		Node(char o) {
			value = o;
		}
	}

	Node root;

	public void add(char value) {
		root = addRecursive(root, value);
	}
	
	public boolean containsNode(int value) {
	    return containsNodeRecursive(root, value);
	}

	private Node addRecursive(Node current, char value) {
		if (current == null) {
			return new Node(value);
		}
		if (value < current.value) {
			current.less = addRecursive(current.less, value);
		} else if (value > current.value) {
			current.more = addRecursive(current.more, value);
		} else {
			return current;
		}
		return current;
	}
	
	private boolean containsNodeRecursive(Node current, int value) {
	    if (current == null) {
	        return false;
	    }
	    if (value == current.value) {
	        return true;
	    }
	    return value < current.value
	      ? containsNodeRecursive(current.less, value)
	      : containsNodeRecursive(current.more, value);
	}
	
	static Tree createTreeFromStr(String s) {
		char [] ms = s.toCharArray();
		Tree t = new Tree();
		for(int i =0; i< ms.length; i++) {
			t.add(ms[i]);
		}
		return t;
	}
	
	public void traverseInOrder(Node node) {
	    if (node != null) {
	        traverseInOrder(node.less);
	        System.out.print(" " + node.value);
	        traverseInOrder(node.more);
	    }
	}

	public static void main(String... gs) {
		Tree t = createTreeFromStr("deabzc");
		System.out.println(t.containsNode((int)'p'));
		t.traverseInOrder(t.root);
	}

}
