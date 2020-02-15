package by.bntu.fitr.varabei.javalabs.lab10.model;

import static by.bntu.fitr.varabei.javalabs.lab10.model.Logic.*;

import java.util.Random;

public abstract class ArrayInitializer {
	private final static int MULTIPLICATOR = 2;

	public static void rndDouble(double[] array, int max) {
		Random random = new Random();//effettive
		for (int i = DEFAULT; i < array.length; i++) {
			array[i] = (Math.random() * (max * MULTIPLICATOR + ONE_POINT)) - max;
		}
	}

}
