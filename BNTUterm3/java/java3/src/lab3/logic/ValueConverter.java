package lab3.logic;

public class ValueConverter {
	static final int THOUSAND_CONV_KB = 1024;
	static final int BT_to_MB = 1048576;
	static final int BILLION_CONV = 1073741824;
	static final long BT_to_TB = 1073741824000L;

	public static double btToKb(double amount_byte) {
		return amount_byte / THOUSAND_CONV_KB;
	}

	public static double btToMb(double amount_byte) {
		return amount_byte / BT_to_MB;
	}

	public static double btToGb(double amount_byte) {
		return amount_byte / BILLION_CONV;
	}
	
	public static double btToTb(double amount_byte) {
		return amount_byte / BT_to_TB ;
	}
	
}
