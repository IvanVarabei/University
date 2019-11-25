package by.bntu.fitr.nameofstudent.javalabs.lab07.model;

import java.util.Random;

public class Dice {
	final static int MAX_DICE = 6;
	final static int MIN = 2;

	public static int throwDice() {
		Random random = new Random();
		return random.nextInt(MAX_DICE) + random.nextInt(MAX_DICE) + MIN;
	}
}
