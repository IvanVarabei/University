package by.bntu.fitr.varabei.javalabs.lab07.model;

public class Leap {
	final static int NORMAL[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
	final static int BISSEXTILE[] = { 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
	final static int NUM_OF_MOANTH = 12;
	final static int MAX_DESEMBER = 31;
	final static int POINT = 1;
	final static int NIL = 0;
	final static int MULTIPLE_4 = 4;
	final static int MULTIPLE_100 = 100;
	final static int MULTIPLE_400 = 400;

	public static boolean isMultiple(int suspect, int mult) {
		return suspect % mult == NIL;
	}

	public static boolean isBissextile(int suspect) {
		boolean multiple4 = isMultiple(suspect, MULTIPLE_4), multiple100 = isMultiple(suspect, MULTIPLE_100),
				multiple400 = isMultiple(suspect, MULTIPLE_400);
		if (multiple4 && multiple100 && multiple400) {
			return true;
		}
		if (multiple4 && multiple100) {
			return false;
		}
		if (multiple4) {
			return true;
		} else {
			return false;
		}
	}

	public static String nextDay(int d, int m, int y) {
		int msMoanths[] = NORMAL;
		if (isBissextile(y)) {
			msMoanths = BISSEXTILE;
		}
		if (m > NUM_OF_MOANTH || msMoanths[m - POINT] < d || y < NIL) {
			return "Input error";
		}
		if (m == NUM_OF_MOANTH && d == MAX_DESEMBER) {
			return "1.1." + (y + POINT);

		}
		if (msMoanths[m - POINT] == d) {
			return "1." + (m + POINT) + "." + y;

		} else {
			return (d + POINT) + "." + m + "." + y;

		}
	}

}
