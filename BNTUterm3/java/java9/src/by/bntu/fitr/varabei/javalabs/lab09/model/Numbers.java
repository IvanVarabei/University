package by.bntu.fitr.varabei.javalabs.lab09.model;

public class Numbers {
	final static int DEFAULT = 0;
	final static int TEN_EXP_ONE = 10;
	final static int ONE_POINT = 1;

	public static int countNotNegativeDegree(int b, int a) {
		int result = b;
		if(a==0) {
			result=1;
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

	public static double approxArifm(int n) {
		int e = lookForExp(n), e1 = countNotNegativeDegree(TEN_EXP_ONE, e - ONE_POINT);
		double sum = DEFAULT;
		for (int i = DEFAULT; i < e; i++, e1 /= TEN_EXP_ONE) {
			sum = sum + n / e1;
			n = n % e1;
		}
		return sum / e;
	}

	public static double approxGeom(int n) {
		int e = lookForExp(n), e1 = countNotNegativeDegree(TEN_EXP_ONE, e - ONE_POINT);
		double composition = ONE_POINT;
		for (int i = DEFAULT; i < e; i++, e1 /= TEN_EXP_ONE) {
			composition = composition * (n / e1);
			n = n % e1;
		}
		return Math.pow(composition, (double) ONE_POINT / e);
	}

}
