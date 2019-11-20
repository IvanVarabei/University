package lab4.utils;

import java.util.Scanner;

public class Input {
	public static double read(String str) {
		System.out.printf("\n"+str+"\n");
		Scanner in = new Scanner(System.in);
		return in.nextDouble();
	}

}
