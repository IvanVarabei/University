package lab5.model;

public class CurrentYear {
	final static int NORMAL[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
	final static String DAY_OF_WEEK[] = { "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY",
			"SUNDAY" };
	final static int NUM_OF_DAYS_IN_WEEK = 7;
	final static int NIL = 0;
	final static int POINT = 1;

	public static String seekDay(int dd, int mm) {
		return DAY_OF_WEEK[seekNumberOfDayInYear(dd, mm) % NUM_OF_DAYS_IN_WEEK];
	}

	public static int seekNumberOfDayInYear(int dd, int mm) {
		int numberOfDayInYear = NIL;
		for (int i = NIL; i < mm - POINT; i++) {
			numberOfDayInYear += NORMAL[i];
		}
		return numberOfDayInYear += dd;
	}

}
