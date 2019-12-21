package by.bntu.fitr.varabei.javalabs.lab10.model;

public class Logic {

	final static int DEFAULT = 0;
	final static int ONE_POINT = 1;
	final static int TEN_EXP_ONE = 10;

	public static double muliplicateNegBefre(double ...arr) {
		int maxPos=getMaxPos(arr);
		double res=ONE_POINT;
		for (int i = DEFAULT; i < maxPos; i++) {
			if (arr[i]<DEFAULT) {
				res*=arr[i];
			}
		}
		return res;
	}
	
	public static double sumPosBefre(double ...arr) {
		int maxPos=getMaxPos(arr);
		double res=DEFAULT;
		for (int i = DEFAULT; i < maxPos; i++) {
			if (arr[i]>DEFAULT) {
				res+=arr[i];
			}
		}
		return res;
	}
	
	public static int getMaxPos(double ...arr) {
		int pos = DEFAULT;
		double max=arr[pos];
		for (int i = DEFAULT; i < arr.length; i++) {
			if (arr[i] > max) {
				pos=i;
				max=arr[i];
			}
		}
		return pos;
	}
	
}
