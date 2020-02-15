package by.bntu.fitr.poisit.varabei.javaexam.model;

public class Logic {

	final static int DEFAULT = 0;
	final static int ONE_POINT = 1;
	final static int TEN_EXP_ONE = 10;

	public static void bubbleSorter(int... a) {
		for (int out = a.length - 1; out >= 1; out--) {
			for (int in = 0; in < out; in++) {
				if (a[in] > a[in + 1]) {
					int dummy = a[in];
					a[in] = a[in + 1];
					a[in + 1] = dummy;
				}
			}
		}
	}

	public static boolean doubleEquals(double a, double b) {
		if (Math.round(a * 100.0) / 100.0 != Math.round(b * 100.0) / 100.0) {
			return false;
		} else {
			return true;
		}
	}

	public static boolean perfectCheck(int n) {
		int summ1 = 0;
		for (int i = 1; i < n; i++) {
			if (n % i == 0) {
				summ1 += i;
			}
		}
		if (n == summ1) {
			return true;
		} else {
			return false;
		}
	}

	public static int stepen(int b, int a) {
		int result = b;
		if (a == 0) {
			result = 1;
		}
		for (int i = ONE_POINT; i < a; i++) {
			result *= b;
		}
		return result;
	}

	public static int lookForExp(int n) {
		int count = DEFAULT;
		for (int i = ONE_POINT; i <= n; i = i * TEN_EXP_ONE) {
			count++;
		}
		return count;
	}

	public static int[] decay(int n) {
		int e = lookForExp(n), e1 = stepen(TEN_EXP_ONE, e - ONE_POINT);
		int[] array = new int[e];
		for (int i = DEFAULT; i < e; i++, e1 /= TEN_EXP_ONE) {
			array[i] = n / e1;
			n = n % e1;
		}
		return array;
	}

	public static int assembly(int... ms) {
		int res = DEFAULT;
		for (int i = DEFAULT, j = ms.length - ONE_POINT; i < ms.length; i++, j--) {
			res += ms[i] * stepen(TEN_EXP_ONE, j);
		}
		return res;
	}

	public static int seekMaxPos(int... args) {
		int pos = 0;
		for (int i = 0; i < args.length; i++) {
			if (args[i] > args[pos]) {
				pos = i;
			}
		}
		return pos;
	}

	public static int seekFirstNilPos(int[] array) {
		int pos = 0;
		for (int i = 0; i < array.length; i++) {
			if (array[i] == 0) {
				pos = i;
				break;
			}
		}
		return pos;
	}

	public static int seekLastNilPos(int[] array) {
		int pos = 0;
		for (int i = array.length - ONE_POINT; i >= 0; i--) {
			if (array[i] == 0) {
				pos = i;
				break;
			}
		}
		return pos;
	}

}
