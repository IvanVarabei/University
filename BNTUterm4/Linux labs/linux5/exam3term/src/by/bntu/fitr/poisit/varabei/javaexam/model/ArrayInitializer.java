package by.bntu.fitr.poisit.varabei.javaexam.model;

import java.util.Random;

public class ArrayInitializer {
	static Random rand = new Random();

	public static int[] intInit(int gap, int... array) {
		for (int i = 0; i < array.length; i++) {
			array[i] = rand.nextInt(gap);
			if (rand.nextInt() % 2 == 0) {
				array[i] = array[i] * -1;
			}
		}
		return array;
	}

	public static double[] dInit(double... array) {
		for (int i = 0; i < array.length; i++) {
			array[i] = rand.nextDouble() * 10;
			if (rand.nextInt() % 2 == 0) {
				array[i] = array[i] * -1;
			}
		}
		return array;
	}

}