package by.bntu.fitr.varabei.javalabs.lab09.view;

import java.io.IOException;
import java.util.Scanner;

public class Input {
	private final static Scanner in = new Scanner(System.in);
	public static double readD(String str) {
		System.err.printf("\n"+str);
		return in.nextDouble();
	}
	public static int readInt(String str) {
		System.err.printf("\n"+str);
		return in.nextInt();
	}
	public static char readChar(String str) throws IOException{
		System.err.printf("\n"+str);
		return (char) System.in.read();
	}

}
