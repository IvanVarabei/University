package Structures;

public class StackArray {

	private int mSize; // mSize - максимальный размер
	private Object[] stackArray;
	private int top;

	public StackArray(int m) {
		this.mSize = m;
		stackArray = new Object[mSize];
		top = -1;
	}

	public void push(Object element) {
        stackArray[++top] = element;
    }
	
	public Object pop() {
		if(top>=0) {
			return stackArray[top--];
		}
		return null;       
    }

	int sum() {
		int sum = 0;
		for(int i = 0; i<= top; i++) {
			sum+=Integer.parseInt(stackArray[i].toString());
		}
		return sum;
	}
	
	public static void main(String... fdsg) {
		StackArray st = new StackArray(10);
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
