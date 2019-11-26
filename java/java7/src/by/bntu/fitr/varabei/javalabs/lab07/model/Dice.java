package by.bntu.fitr.varabei.javalabs.lab07.model;

import java.util.Random;

public class Dice {
	final static int MAX_DICE = 6;
	final static int MIN_DICE = 1;

//3 values, concatenation
	public static int throwDice() {
		Random random = new Random();
		int dice1 = random.nextInt(MAX_DICE) + MIN_DICE;
		int dice2 = random.nextInt(MAX_DICE) + MIN_DICE;
		return random.nextInt(MAX_DICE) + random.nextInt(MAX_DICE) ;
	}
}
