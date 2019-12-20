package lab3.logic;

public class MassConverter {
	static final int THOUSAND_CONVERTER_KILLOS = 1000;
	static final int TEN_THOUSAND_CONV_KINT = 10000;
	static final int MILLION_CONV_TONS = 1000000;

	public static double gramsToKillos(double grams) {
		return grams / THOUSAND_CONVERTER_KILLOS;
	}

	public static double gramsToKintals(double grams) {
		return grams / TEN_THOUSAND_CONV_KINT;
	}

	public static double gramsToTons(double grams) {
		return grams / MILLION_CONV_TONS;
	}
}
