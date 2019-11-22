package lab5.model;

public class Numbers {
	final static int NIL = 0;
	final static int TEN_EXP_ONE = 10;
	final static double ONE_POINT = 1;

	public static int lookForExp(int n) {
		int count = NIL;
		for (int i = (int) ONE_POINT; i <= n; i = i * TEN_EXP_ONE) {
			count++;
		}
		return count;
	}

	public static double approxArifm(int n) {
		int e = lookForExp(n), e1 = (int) ONE_POINT;
		double sum = NIL;
		for (int i = (int) ONE_POINT; i < e; i++) {
			e1 *= TEN_EXP_ONE;
		}
		for (int i = NIL; i < e; i++, e1 /= TEN_EXP_ONE) {
			sum = sum + n / e1;
			n = n % e1;
		}
		return sum / e;
	}

	public static double approxGeom(int n) {
		int e = lookForExp(n), e1 = (int) ONE_POINT;
		double composition = ONE_POINT;
		for (int i = (int) ONE_POINT; i < e; i++) {
			e1 *= TEN_EXP_ONE;
		}
		for (int i = NIL; i < e; i++, e1 /= TEN_EXP_ONE) {
			composition = composition * (n / e1);
			n = n % e1;
		}

		return Math.pow(composition, ONE_POINT / e);
	}

}
