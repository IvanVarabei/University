package arrays;

import java.io.IOException;
import java.util.Arrays;
import java.util.Scanner;

public class Life {

	static String MENU = "1 - Set cells\n2 - GO!";
	static Scanner in = new Scanner(System.in);
	int current[][];
	int next[][];

	public Life(int n) {
		current = new int[n][n];
		next = new int[n][n];
	}

	public void setCell(int x, int y) {
		current[x][y] = 1;
		next[x][y] = 1;
	}
	
	//public boolena compare()

	public void show() {
		for (int[] i : next) {
			for (int j : i) {
				System.out.print(j + " ");
			}
			System.out.println();
		}
		System.out.println();
	}

	public void go() {
		int counter;
		for (int i = 0; i < next.length; i++) {
			for (int j = 0; j < next.length; j++) {
				counter = 0;

				for (int i1 = i - 1; i1 < i + 2; i1++) {
					for (int j1 = j - 1; j1 < j + 2; j1++) {

						if (i1 >= 0 && j1 >= 0 && i1 < next.length && j1 < next.length && (i1 != i || j1 != j)) {
							if (current[i1][j1] == 1) {
								counter++;
							}
						}
					}
				}
				switch (counter) {
				case 2:
					break;
				case 3:
					next[i][j] = 1;
					break;
				default:
					next[i][j] = 0;
				}
			}
		}
		current = copy(next);
	}

	

	public static void main(String... fd) throws InterruptedException, IOException {
		Life life = new Life(readInt("Enter matrix dimension : "));
		int delay = readInt("Enter delay : ");
		while(true) {
			System.out.println(MENU);
			switch(readInt("Enter action : ")) {
			case 1:
				while(readInt("Enter 0 to enterapt setting cells and go along!\nelse enter 1 : ")!=0) {
					life.setCell(readInt("Enter x : "), readInt("Enter y : "));
				}
				break;
			case 2:
				while(true) {
					new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
					life.show();
					Thread.sleep(delay);
					life.go();
				}
			}
		}
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
	
	static int[][] copy(int[][] ms) {
		int[][] result = new int[ms.length][ms.length];
		for (int i = 0; i < ms.length; i++) {
			for (int j = 0; j < ms.length; j++) {
				result[i][j] = ms[i][j];
			}
		}
		return result;
	}
//cd C:\Users\Asus\Desktop\algorithm\Algorithm\bin
	//9*9
}
