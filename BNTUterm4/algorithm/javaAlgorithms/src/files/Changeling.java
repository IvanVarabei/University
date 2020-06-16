package files;

import java.io.FileInputStream;
import java.io.IOException;

public class Changeling {

	public static void main(String... fdgsgf) throws IOException {
		try (FileInputStream fin = new FileInputStream("changeling.txt")) {
			int first = 0, counter = 0;
			char previous = '0';
			char[] buffer = new char[20];
			boolean isReadingStarted = false;

			while (true) {
				int i = fin.read();
				if (isSeparator(previous) && !isSeparator(i)) {
					counter = 0;
				}
				if (!isSeparator(previous) && isSeparator(i) && isChangeling(buffer,counter)) {
					printWord(buffer, counter);
				}
				if (i == -1)
					break;
				buffer[counter++] = previous = toLower(i);
			}
		}

	}
	static boolean isChangeling(char[] buffer,int counter) {
		for(int i=0, j = counter-1; i<=j;i++,j--) {
			if(buffer[i]!=buffer[j]) {
				return false;
			}
		}
		return true;
	}
	static char toLower(int c) {
		if (c <= 90 && c >= 65) {
			c = c + 32;
		}
		return (char) c;
	}

	static void printWord(char[] buffer, int counter) {
		for (int j = 0; j < counter; j++) {
			System.out.print(buffer[j]);
		}
		System.out.println();
	}

	static boolean isSeparator(int s) {
		int separators[] = { ' ', ',', '.', ':', ';', -1, '\n', '\r' };
		for (int i = 0; i < separators.length; i++) {
			if (s == separators[i]) {
				return true;
			}
		}
		return false;
	}
}
