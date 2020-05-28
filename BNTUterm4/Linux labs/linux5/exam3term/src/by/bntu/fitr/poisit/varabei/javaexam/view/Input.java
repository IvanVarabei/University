 package by.bntu.fitr.poisit.varabei.javaexam.view;

import java.util.Scanner;
import java.io.IOException;

public class Input {
	static Scanner in = new Scanner(System.in);

	public static int readInt(String str) {
		System.out.println(str);
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
		System.out.println(str);
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

}