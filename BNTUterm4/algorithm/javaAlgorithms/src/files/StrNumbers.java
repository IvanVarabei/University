package files;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

public class StrNumbers {

	public static void main(String... fdgsgf) throws IOException {
		String f = "StrNumbers.txt";
		addNumbers(f);
	}

	static void addNumbers(String f) throws IOException {
		List<String> lines = Files.readAllLines(Paths.get(f), StandardCharsets.UTF_8);
		for (int i = 0; i < lines.size(); i++)
			lines.set(i, "" + (i + 1) + " . " + lines.get(i));
		try (PrintStream printStream = new PrintStream(new FileOutputStream("StrNumbers.txt", false))) {
			for (int i = 0; i < lines.size(); i++)
				printStream.println(lines.get(i));
		}
	}

}
