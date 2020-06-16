package arrays;

import java.lang.reflect.Array;
import java.util.Arrays;

public class Attempt {

	/*т
комерческий
стартап
личный проек
учебный проект
*командный
*
*интернет магазин
*
*онлайн система тестирования(админ. ментор. студент. аналитик) 
*/
	public Attempt() {

	}

	// в каком домене ваши проекты
	// демон техники
	// корман алгоритмы и структуры данных осел
	public static void main(String... ms) {
		System.out.println("Hello");
		int ms1[] = { 3, 6, 1, 7, 9, 3, 0 };
		System.out.println(Arrays.toString(ms1));
		buble(ms1);
		System.out.println(Arrays.toString(ms1));

		int ms3[] = { 3, 6, 1, 7, 9, 3, 0 };
		System.out.println(Arrays.toString(ms3));
		quick(ms3, 0, ms3.length - 1);
		System.out.println(Arrays.toString(ms3));
	}

	public static void quick(int[] ms, int low, int high) {
		if (ms.length == 0)
			return;
		if (low >= high)
			return;
		int pivot = ms[(high + low) / 2];
		int i = low, j = high;
		while (i <= j) {
			while (ms[i] < pivot) {
				i++;
			}
			while (ms[j] > pivot) {
				j--;
			}
			if (i <= j) {
				int c = ms[i];
				ms[i] = ms[j];
				ms[j] = c;
				i++;
				j--;
			}
		}
		if (low < j) {
			quick(ms, low, j);
		}
		if (high > i) {
			quick(ms, i, high);
		}

	}

	public static void buble(int[] ms) {
		for (int i = 0; i < ms.length; i++) {
			for (int j = ms.length - 1; j > i; j--) {
				if (ms[j - 1] > ms[j]) {
					int c = ms[j];
					ms[j] = ms[j - 1];
					ms[j - 1] = c;
				}
			}
		}
	}

	// public static quick

}
