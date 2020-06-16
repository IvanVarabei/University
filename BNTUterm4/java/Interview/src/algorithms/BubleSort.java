package algorithms;

import java.util.Arrays;

public class BubleSort {

	public static void main(String... dfgsf) {
		int ms[] = { 3, 6, 1, 0, 9, -2, 3 ,-100,};
		System.out.println(Arrays.toString(ms));
		bubleSort(ms);
		System.out.println(Arrays.toString(ms));
	}
	
	static void bubleSort(int ms[]) {
		for (int i = 0; i < ms.length; i++) {
			for (int j = ms.length - 1; i < j; j--) {
				if(ms[j]<ms[j-1]) {
					int temp = ms[j];
					ms[j] = ms[j-1];
					ms[j-1] = temp;
				}
			}
		}
	}

}
