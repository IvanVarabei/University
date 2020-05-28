package arrays;

import java.util.Arrays;
import java.util.Scanner;

public class Shift {

	private static Scanner in = new Scanner(System.in);

	public static void main(String... df) {
		int ms[] = { 1, 2, 3, 4, 5, 6, 7 };
		System.out.println("Initial array : " + Arrays.toString(ms));
		System.out.println("n = " + ms.length);
		System.out.println("Result array : " + Arrays.toString(leftShift(readInt("Enter m : "), ms)));
	}

	public static int[] leftShift(int m, int[] ms) {
		int[] newMs = Arrays.copyOf(ms, ms.length);
		for (int i = 0; i < m; i++) {
			for (int j = 0; j < ms.length - 1; j++) {
				int c = newMs[j];
				newMs[j] = newMs[j + 1];
				newMs[j + 1] = c;
			}
		}
		return newMs;
	}

	public final static int readInt(String str) {
		System.out.print(str);
		boolean flag = false;
		while (!flag) {
			if (!in.hasNextInt()) {
				System.out.println("Try again: ");
				in.nextLine();
			} else {
				flag = true;
			}
		}
		return in.nextInt();
	}

}
