package files;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

public class BracketBalance {

	public static void main(String... fdgsgf) throws IOException {
		System.out.println(isBracketBalance("BracketBalance.txt"));

	}

	static boolean isBracketBalance(String f) throws FileNotFoundException, IOException {
		try (FileInputStream fin = new FileInputStream(f)) {
			int openBrackets = 0, closeBrackets = 0, i;
			while ((i = fin.read()) != -1) {
				if (i == '{')
					openBrackets++;
				if (i == '}')
					closeBrackets++;
			}
			return openBrackets == closeBrackets;
		}
	}
}
