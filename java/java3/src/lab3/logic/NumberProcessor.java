package lab3.logic;

public class NumberProcessor {
	public double a;
	public double b;

	public NumberProcessor(double a1, double b1) {
		a = a1;
		b = b1;
	}

	public double getFirst(NumberProcessor instance) {
		return instance.a;
	}

	public double getSecond(NumberProcessor instance) {
		return instance.b;
	}

	public void change() {
		a = a + b;
		b = a - b;
		a = a - b;
	}
}
