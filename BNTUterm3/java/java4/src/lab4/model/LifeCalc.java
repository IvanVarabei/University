package lab4.model;

import java.util.Calendar;
import java.util.GregorianCalendar;

public class LifeCalc {
	static final int POINT = 1;
	static final int DAY_IN_MONTH = 30;
	static final int DAY_IN_YEAR = 365;
	static final int HOUR_IN_DAY = 24;
	static final int MIN_IN_HOUR = 60;
	static final int WEEK_LENTH = 7;

	public static int countAgeSeconds(double birthDay, double birthMonth, double birthYear) {
		return countAgeMinets(birthDay, birthMonth, birthYear) * MIN_IN_HOUR;
	}

	public static int countAgeMinets(double birthDay, double birthMonth, double birthYear) {
		return countAgeHours(birthDay, birthMonth, birthYear) * MIN_IN_HOUR;
	}

	public static int countAgeHours(double birthDay, double birthMonth, double birthYear) {
		return countAgeDays(birthDay, birthMonth, birthYear) * HOUR_IN_DAY;
	}

	public static int countAgeDays(double birthDay, double birthMonth, double birthYear) {
		GregorianCalendar calendar = new GregorianCalendar();
		int xDay = calendar.get(Calendar.DAY_OF_MONTH) - (int) birthDay;
		int xMonth = calendar.get(Calendar.MONTH) +POINT - (int) birthMonth;
		int xYear = calendar.get(Calendar.YEAR) - (int) birthYear;
		int days = xDay + xMonth * DAY_IN_MONTH + xYear * DAY_IN_YEAR;
		return days;
	}

	public static int countAgeWeeks(double birthDay, double birthMonth, double birthYear) {
		return countAgeDays(birthDay, birthMonth, birthYear) / WEEK_LENTH;
	}

	public static int countAgeMoanths(double birthDay, double birthMonth, double birthYear) {
		return countAgeDays(birthDay, birthMonth, birthYear) / DAY_IN_MONTH;
	}
}
