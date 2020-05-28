package files;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Arrays;

public class Frequency {
	static final int amount = 32;

	public static void main(String... fdgsgf) throws IOException {
		String result[] = countFrequence("Frequency.txt");
		for(int i =0; i<amount; i++)
			System.out.println(result[i]);

	}

	static String[] countFrequence(String file) throws FileNotFoundException, IOException {
		try (FileInputStream fin = new FileInputStream(file)) {
			int[] frequency = new int[amount];
			int letter;
			while ((letter = fin.read()) != -1) {
				if (toLower(letter) >= 224 && toLower(letter) <= 255) {
					letter = toLower(letter) - 224;
					frequency[letter] += 1;
				}
			}
			return countAmounts(frequency);
		}
	}

	static String[] countPercents(int[] frequency) {
		int general = 0;
		String persents[] = new String[amount];
		for (int i = 0; i < amount; i++) {
			general += frequency[i];
		}
		for (int i = 0; i < amount; i++) {
			persents[i] = "" + (char) (i + 1072) + ":" +
		String.format("%.2f",(100 * frequency[i]) / (double) general) 
		+ "%";
		}
		return persents;
	}
	
	static String[] countAmounts(int[] frequency) {
		int general = 0;
		String amounts[] = new String[amount];
		for (int i = 0; i < amount; i++) {
			general += frequency[i];
		}
		for (int i = 0; i < amount; i++) {
			amounts[i] = "" + (char) (i + 1072) + ":" +frequency[i];
		}
		return amounts;
	}

	static char toLower(int c) {
		if (c >= 192 && c <= 223) {
			c = c + amount;
		}
		return (char) c;
	}

}

//à-ÿ 1072 - 1103
	// À-ß 1040 - 1071
	// à-ÿ 224 - 255
	// À-ß 192 - 223
