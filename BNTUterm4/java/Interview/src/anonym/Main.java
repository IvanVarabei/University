package anonym;

/*
dequeue 7java
offer~add - offerLast
poll-gets and removes first - pollFirst
peek - gets first but doesn t removes

queue
dequeue - two tails double queue{
offerFirs()
offerLast()
pollFirs
pollLast
peekFirst
peekLast
}
ArrayDequeue - stack array
*/
class Popcorn{
	
	void doSome() {
		System.out.println("Pop");
	}
	
	void second() {
		System.out.println("Second");
	}
}

public class Main {

	public static void main(String ...rf) {
		Popcorn popcorn = new Popcorn() {		
			void doSome() {
				System.out.println("Main");
			}
		};
		popcorn.doSome();
		popcorn.second();
		
		Comparable comp = new Comparable() {//We can override interfaces as
			@Override
			public int compareTo(Object o){
				return 0;
			}
		};
		comp.compareTo(new Object());
		
		
		method(new Popcorn() {
			void doSome() {
				System.out.println("bla");
			}
		});
		popcorn.doSome();
	}
	
	static void method(Popcorn p) {
		p.doSome();
	}

}
