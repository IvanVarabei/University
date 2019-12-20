package lab5.model;

public class Century {
	final static int SECOND_EXP = 100;
	final static int ZERO = 0;

	public static int compute—enturies(int year) {
		int century = year / SECOND_EXP;
		if (century % SECOND_EXP != ZERO) {
			century++;
		}
		return century;
	}
}
