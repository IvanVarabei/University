package by.bntu.fitr.varabei.javalabs.lab10.model;

public abstract class Logic {//vector

	final static int DEFAULT = 0;
	final static int ONE_POINT = 1;
	final static int TEN_EXP_ONE = 10;

	private static int getMaxPos(double... arr) {
		int pos = DEFAULT;
		for (int i = DEFAULT; i < arr.length; i++) {
			if (arr[i] > arr[pos]) {
				pos = i;
			}
		}
		return pos;
	}

	public static double muliplicateNegBefre(double... arr) {
		int maxPos = getMaxPos(arr);
		double res = ONE_POINT;
		for (int i = DEFAULT; i < maxPos; i++) {
			if (arr[i] < DEFAULT) {
				res *= arr[i];
			}
		}
		return res;
	}

	public static double sumPosBefre(double... arr) {
		int maxPos = getMaxPos(arr);
		double res = DEFAULT;
		for (int i = DEFAULT; i < maxPos; i++) {
			if (arr[i] > DEFAULT) {
				res += arr[i];
			}
		}
		return res;
	}

}
