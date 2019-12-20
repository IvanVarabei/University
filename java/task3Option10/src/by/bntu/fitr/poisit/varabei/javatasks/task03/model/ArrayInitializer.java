package by.bntu.fitr.poisit.varabei.javatasks.task03.model;

import java.util.Random;

public class ArrayInitializer {
	public static void rndInit(int[] array,  int max) {
		Random random = new Random();
		for (int i = 0; i < array.length; i++) {
			array[i] = (int) (Math.random()*(max*2+1))-max;
		}
	}
}
