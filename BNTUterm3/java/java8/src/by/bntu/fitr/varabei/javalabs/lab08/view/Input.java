package by.bntu.fitr.varabei.javalabs.lab08.view;

import java.io.IOException;
import java.util.Scanner;

public class Input {
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

	public static char readChar(String str) throws IOException {
		System.out.printf("\n" + str);
		return (char) System.in.read();
	}

}
