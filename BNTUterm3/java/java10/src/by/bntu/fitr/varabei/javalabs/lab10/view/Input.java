package by.bntu.fitr.varabei.javalabs.lab10.view;

import java.util.Scanner;

public abstract class Input {
	private final static Scanner in = new Scanner(System.in);

	public static int readInt(String str) {
		boolean correct = false;
		System.out.print(str);
		while (!correct) {
			if (!in.hasNextInt()) {
				System.out.print("Try again : ");
				in.nextLine();
			} else
				correct = true;
		}
		return in.nextInt();
	}

	public static Double readD(String str) {
		boolean correct = false;
		System.out.print(str);
		while (!correct) {
			if (!in.hasNextDouble()) {
				System.out.print("Try again : ");
				in.nextLine();
			} else
				correct = true;
		}
		return in.nextDouble();
	}
}