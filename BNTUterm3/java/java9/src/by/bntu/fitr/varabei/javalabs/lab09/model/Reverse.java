package by.bntu.fitr.varabei.javalabs.lab09.model;

import static by.bntu.fitr.varabei.javalabs.lab09.model.Numbers.*;
import static by.bntu.fitr.varabei.javalabs.lab09.model.Figure.*;

public class Reverse {

	public static int figureOutNils(int n, int size) {
		int temp = TEN_EXP_ONE, counter = DEFAULT;
		for (int i = --size; i > DEFAULT; i--, temp *= TEN_EXP_ONE) {
			if (n % temp == DEFAULT) {
				counter++;
			}
		}
		return counter;
	}

	public static int assembly(int... ms) {
		int res = DEFAULT;
		for (int i = DEFAULT, j = ms.length - ONE_POINT; i < ms.length; i++, j--) {
			res += ms[i] * countNotNegativeDegree(TEN_EXP_ONE, j);
		}
		return res;
	}

	public static int doReverse(int n) {
		int e = lookForExp(n), initNils = figureOutNils(n, e);
		n = n / countNotNegativeDegree(TEN_EXP_ONE, initNils);
		e = lookForExp(n);
		int ms[] = dissectToFigures(n, e--);
		for (int i = DEFAULT, j = e; i < j; i++, j--) {
			int temp = ms[i];
			ms[i] = ms[j];
			ms[j] = temp;
		}
		return assembly(ms) * countNotNegativeDegree(TEN_EXP_ONE, initNils);
	}
}
