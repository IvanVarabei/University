package lab5.model;

import java.util.Date;

public class CurrentDay {
	final static int SECONDS_IN_MINET = 60;

	public static Date showDate() {
		Date now = new Date();
		return now;
	}

	@SuppressWarnings("deprecation")
	public static int discoverHourNum() {
		Date now = new Date();
		return now.getHours();
	}

	@SuppressWarnings("deprecation")
	public static int discoverMinetsNum() {
		Date now = new Date();
		return now.getMinutes() + now.getHours() * SECONDS_IN_MINET;
	}

	@SuppressWarnings("deprecation")
	public static int discoverSecondsNum() {
		Date now = new Date();
		return now.getSeconds() + now.getMinutes() * SECONDS_IN_MINET
				+ now.getHours() * SECONDS_IN_MINET * SECONDS_IN_MINET;
	}
}
