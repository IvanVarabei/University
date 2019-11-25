package by.bntu.fitr.nameofstudent.javalabs.lab07.model;

import java.util.Random;

public class Mood {
	final static String GOOD_MOOD = "=)";
	final static String FURIOUS = "=(";
	final static String NORMAL_MOOD = "=|";
	final static int MAX_SPIRITS = 3;
	final static int NIL_NUM = 0;
	final static int FIRST = 1;
	final static int SECOND = 2;

	public static String determineSpirits() {
		String result = "";
		Random random = new Random();
		switch (random.nextInt(MAX_SPIRITS)) {
		case NIL_NUM:
			result = GOOD_MOOD;
			break;
		case FIRST:
			result = NORMAL_MOOD;
			break;
		case SECOND:
			result = FURIOUS;
			break;
		}
		return result;
	}
}
