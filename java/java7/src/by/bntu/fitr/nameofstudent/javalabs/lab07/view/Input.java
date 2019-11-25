package by.bntu.fitr.nameofstudent.javalabs.lab07.view;

import java.io.IOException;
import java.util.Scanner;

public class Input {
	public static double read(String str) {
		System.err.printf("\n"+str);
		Scanner in = new Scanner(System.in);
		return in.nextDouble();
	}
	public static int readInt(String str) {
		System.err.printf("\n"+str);
		Scanner in = new Scanner(System.in);
		return in.nextInt();
	}
	public static char readChar(String str) throws IOException{
		System.err.printf("\n"+str);
		Scanner in = new Scanner(System.in);
		return (char) System.in.read();
	}

}
