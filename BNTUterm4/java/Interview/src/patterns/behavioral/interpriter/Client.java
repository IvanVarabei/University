package patterns.behavioral.interpriter;

import java.util.Deque;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Stack;

public class Client {
	final static String OPERATORS = "+*-/";
	static String prepare(String s) {
		char [] ms = s.toCharArray();
		String numbers = "";
		String opers = "";
		for(int i = 0; i<ms.length; i++) {
			if(OPERATORS.indexOf(ms[i])==-1) {
				numbers+=ms[i];
			}
			else {
				opers+=ms[i];
			}
		}
		return numbers + opers;
	}
	
	public static void main(String ...fg) {
		String context = prepare("8/2+9*3-1");
		Deque<Exp> que = new LinkedList();
		for(char c : context.toCharArray()) {
			Exp resultExp;
			if(OPERATORS.indexOf(c)==-1) {
				resultExp = new Number(c-48);
				que.addLast(new Number(resultExp.evaluate()));
			}
			else {
				Exp left = que.poll();
				Exp right = que.poll();
				
				switch(c){
				case '+':
					resultExp = new AddExp(left,right);
					break;
				case '*':
					resultExp = new MultExp(left,right);
					break;
				case '-':
					resultExp = new SubtractExp(left,right);
					break;
				case '/':
					resultExp = new DivideExp(left,right);
					break;
				default:
					resultExp = new Number(0);
				}
				que.addFirst(new Number(resultExp.evaluate()));
			}
			
		}
		System.out.println("Result : " + que.poll().evaluate());
	}
}



interface Exp {
	int evaluate();
}

class Number implements Exp {
	int n;

	Number(int num) {
		n = num;
	}

	public int evaluate() {
		return n;
	}
}

class AddExp implements Exp {
	Exp first;
	Exp second;

	AddExp(Exp one, Exp two) {
		first = one;
		second = two;
	}

	public int evaluate() {
		return first.evaluate() + second.evaluate();
	}
}
class SubtractExp implements Exp {
	Exp first;
	Exp second;

	SubtractExp(Exp one, Exp two) {
		first = one;
		second = two;
	}

	public int evaluate() {
		return first.evaluate() - second.evaluate();
	}
}
class DivideExp implements Exp {
	Exp first;
	Exp second;

	DivideExp(Exp one, Exp two) {
		first = one;
		second = two;
	}

	public int evaluate() {
		return first.evaluate() / second.evaluate();
	}
}
class MultExp implements Exp {
	Exp first;
	Exp second;

	MultExp(Exp one, Exp two) {
		first = one;
		second = two;
	}

	public int evaluate() {
		return first.evaluate() * second.evaluate();
	}
}
