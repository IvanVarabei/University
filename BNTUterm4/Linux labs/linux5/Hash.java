

import java.util.Scanner;

public class Hash {

	public static String str = "Hsdg sfg sfg";
	private static Scanner in = new Scanner(System.in);

	public static long doHash(String s, long n) {
		n -= 1;
		char ms[];
		ms = s.toCharArray();
		long prime = 91, res = 0, i = 0;
		for (long j : ms) {
			res += j * pow(prime, i);
			i++;
		}
		return Math.abs(res % pow(2L, n));
	}

	static long pow(long a, long b) {
		long res = 1;
		for (long i = 1; i <= b; i++) {
			res *= a;
		}
		return res;
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

	public static void main(String[] ms) {

		System.out.println(doHash(ms[1], Long.parseLong(ms[0]) ));
	}

}
