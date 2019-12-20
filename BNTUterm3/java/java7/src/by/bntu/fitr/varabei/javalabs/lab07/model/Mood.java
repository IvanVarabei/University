package by.bntu.fitr.varabei.javalabs.lab07.model;

import java.util.Random;

public class Mood {
	public final static String GOOD_MOOD = "=)";
	public final static String FURIOUS = "=(";
	public final static String NORMAL_MOOD = "=|";
	public final static int MAX_SPIRITS = 3;

	public static String determineSpirits() {
		String result = GOOD_MOOD;
		Random random = new Random();
		
		switch (random.nextInt(MAX_SPIRITS)) {
		case 1:
			result = NORMAL_MOOD;
			break;
		case 2:
			result = FURIOUS;
			break;
		}
		
		return result;
	}
}
