package model;

import java.util.Arrays;
import java.util.Scanner;
import model.Developer;
import java.io.IOException;

public class Utils {
	
	private static Scanner in = new Scanner(System.in);
	
	public static int searchIndexByValue(int[] ms, int value) {
		int result = Integer.MAX_VALUE;
		for (int i = 0; i < ms.length; i++) {
			if (ms[i] == value) {
				result = i;
			}
		}
		return result;
	}

	public static Developer binarySearch(Developer[] ms, int elem) {
		Developer[] newMs = Arrays.copyOf(ms, ms.length);
		newMs = sortIdMinToMax(newMs);
		int l = 0, r = ms.length - 1;

		while (l <= r) {
			int midl = (l + r) / 2;
			if (newMs[midl].getId() == elem) {
				return newMs[midl];
			} else if (newMs[midl].getId() < elem) {
				l = midl + 1;
			} else if (newMs[midl].getId() > elem) {
				r = midl - 1;
			}

		}

		return new Developer(null, 0, false, 0, elem);
	}

	

	public static int readInt(String str) {
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

	public static double readD(String str) {
		System.out.print(str);
		boolean flag = false;
		while (!flag) {
			if (!in.hasNextDouble()) {
				System.out.println("Try again: ");
				in.nextLine();
			} else {
				flag = true;
			}
		}
		return in.nextDouble();
	}

	public static double readChar(String str) throws IOException {
		System.out.printf("\n" + str);
		return (char) System.in.read();
	}

	public static String readStr(String str) {
		System.out.print(str);
		return in.next();
	}

	public static Developer[] sortAge(Developer[] ms) {
		for (int i = 0; i < ms.length; i++) {
			for (int j = ms.length - 1; j > i; j--) {
				if (ms[j].getAge() > ms[j - 1].getAge()) {
					Developer c = new Developer(ms[j]);
					ms[j] = ms[j - 1];
					ms[j - 1] = c;
				}
			}
		}
		return ms;
	}

	public static Developer[] sortName(Developer[] ms) {
		for (int i = 0; i < ms.length; i++) {
			for (int j = ms.length - 1; j > i; j--) {
				if (ms[j].getName().compareTo(ms[j - 1].getName()) < 0) {
					Developer c = new Developer(ms[j]);
					ms[j] = ms[j - 1];
					ms[j - 1] = c;
				}
			}
		}
		return ms;
	}

	public static Developer[] sortSkill(Developer[] ms) {
		for (int i = 0; i < ms.length; i++) {
			for (int j = ms.length - 1; j > i; j--) {
				if (ms[j].getSkill() > ms[j - 1].getSkill()) {
					Developer c = new Developer(ms[j]);
					ms[j] = ms[j - 1];
					ms[j - 1] = c;
				}
			}
		}
		return ms;
	}

	public static Developer[] sortIdMinToMax(Developer[] ms) {
		for (int i = 0; i < ms.length; i++) {
			for (int j = ms.length - 1; j > i; j--) {
				if (ms[j].getId() < ms[j - 1].getId()) {
					Developer c = new Developer(ms[j]);
					ms[j] = ms[j - 1];
					ms[j - 1] = c;
				}
			}
		}
		return ms;
	}

	public static int rand(int from, int to) {
		return from + (int) (Math.random() * (to + 1 - from));
	}

	public static Developer[] addElem(Developer[] devs, Developer elem) {
		Developer[] newMs = Arrays.copyOf(devs, devs.length + 1);
		newMs[newMs.length - 1] = elem;
		return newMs;
	}

	public static int[] addElem(int[] devs, int elem) {
		int[] newMs = Arrays.copyOf(devs, devs.length + 1);
		newMs[newMs.length - 1] = elem;
		return newMs;
	}

	public static int[] delElem(int[] ms, int index) {
		int[] result = new int[ms.length - 1]; // ms which will contain the result.
		// Copy the elements at the left of the index.
		System.arraycopy(ms, 0, result, 0, index);
		// Copy the elements at the right of the index.
		System.arraycopy(ms, index + 1, result, index, ms.length - index - 1);
		return result;
	}

	public static Developer[] delElem(Developer[] ms, int index) {
		Developer[] result = new Developer[ms.length - 1]; // ms which will contain the result.
		// Copy the elements at the left of the index.
		System.arraycopy(ms, 0, result, 0, index);
		// Copy the elements at the right of the index.
		System.arraycopy(ms, index + 1, result, index, ms.length - index - 1);
		return result;
	}

	public static Developer[] combainArrays(Developer[] ms1, Developer[] ms2) {
		Developer[] res = new Developer[ms1.length + ms2.length];
		int i = 0;
		for (; i < ms1.length; i++) {
			res[i] = ms1[i];
		}
		int j = i;
		for (int j1 = 0; j < res.length; j++, j1++) {
			res[j] = ms2[j1];
		}
		return res;
	}
}
