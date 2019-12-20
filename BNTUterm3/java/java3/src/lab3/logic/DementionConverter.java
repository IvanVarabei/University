package lab3.logic;

public class DementionConverter {
	static final int HUNDRED_CONV_METR= 100;
	static final int HUNDRED_THOUSAND_CONV_KM = 100000;

	public static double smToMetr(double sm) {
		return sm / HUNDRED_CONV_METR;
	}

	public static double smToKm(double sm) {
		return sm / HUNDRED_THOUSAND_CONV_KM;
	}
}
