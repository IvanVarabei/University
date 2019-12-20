package by.bntu.fitr.varabei.javalabs.lab09.model;

import static by.bntu.fitr.varabei.javalabs.lab09.model.Numbers.*;

public class Prime {
	final static int FIRST_DIVISOR = 2;

	public static boolean isPrime(int n) {
		boolean res = true;
		for (int i = FIRST_DIVISOR; i < n; i++) {
			if (n % i == DEFAULT) {
				res = false;
				break;
			}
		}
		return res;
	}

	public static int getPrimeByNumber(int n) {
		int count = DEFAULT;
		for (int i = FIRST_DIVISOR;; i++) {
			if (isPrime(i) == true) {
				count++;
			}
			if (count == n) {
				return i;
			}
		}
	}
}
