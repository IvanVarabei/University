package files;

import java.io.FileInputStream;
import java.io.IOException;

public class Sum {
	static int sum = 0;

	public static void main(String... fdgsgf) throws IOException {
		try (FileInputStream fin = new FileInputStream("sum.txt")) {
			int counter = 0;
			char previous = '0';
			char[] buffer = new char[20];
			boolean isNegative = false;
			while (true) {
				int i = fin.read();
				if (isSeparator(previous) && !isSeparator(i)) {
					if (previous == '-') {
						isNegative = true;
					} else
						isNegative = false;
					counter = 0;
				}
				if (!isSeparator(previous) && isSeparator(i)) {
					add(buffer, counter, isNegative);
				}
				if (i == -1)
					break;
				buffer[counter++] = previous = (char) i;
			}
			System.out.println(sum);
		}

	}

	static void add(char[] buffer, int counter, boolean isNegative) {
		char num[] = new char[counter];
		for (int j = 0; j < counter; j++) {
			num[j] = buffer[j];
		}
		int value = Integer.parseInt(new String(num));
		if (isNegative)
			value = (-1) * value;
		sum += value;
	}

	static boolean isSeparator(int s) {
		return s < 48 || s > 57;
	}

}