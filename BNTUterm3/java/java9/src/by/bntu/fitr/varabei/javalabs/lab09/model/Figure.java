package by.bntu.fitr.varabei.javalabs.lab09.model;

import static by.bntu.fitr.varabei.javalabs.lab09.model.Numbers.*;

public class Figure {

	public static int[] dissectToFigures(int n, int size) {
		int ms[] = new int[size], e1 = countNotNegativeDegree(TEN_EXP_ONE, size - ONE_POINT);
		for (int i = DEFAULT; i < size; i++, e1 /= TEN_EXP_ONE) {
			ms[i] = n / e1;
			n = n % e1;
		}
		return ms;
	}

	public static boolean isSameFigures(int n) {
		int e = lookForExp(n), ms[] = dissectToFigures(n, e);
		boolean result = false;
		for (int i = DEFAULT; i < e; i++) {
			int current = ms[i];
			for (int j = i + ONE_POINT; j < e; j++) {
				if (current == ms[j]) {
					result = true;
				}
			}
		}
		return result;
	}

}
