package lab5.model;

public class Figure {
	final static int ZERO = 0;
	final static int FIRS_EXP = 10;

	public static int summa(int n) {
		int sum = ZERO;
		while (n != ZERO) {
			sum += (n % FIRS_EXP);
			n /= FIRS_EXP;
		}
		return sum;
	}

	public static int miltiplication(int m) {
		int mul = 1;
		while (m != ZERO) {
			mul *= (m % FIRS_EXP);
			m /= FIRS_EXP;
		}
		return mul;
	}
}
