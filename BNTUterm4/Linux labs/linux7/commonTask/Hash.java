import java.util.Scanner;
import java.io.*;

public class Hash {

	public static long doHash(String s, long n) {

		n -= 1;
		char ms[];
		ms = s.toCharArray();
		long prime = 91, res = 0, i = 0;
		for (long j : ms) {
			res += j * pow(prime, i);
			i++;
		}
		return Math.abs(res % pow(2L, n));
	}

	static long pow(long a, long b) {
		long res = 1;
		for (long i = 1; i <= b; i++) {
			res *= a;
		}
		return res;
	}

	public static void main(String[] ms) {
		int nBits = 0;
		String newStr = "";
		String line;
		int i = 0;
		try {

			File resF = new File("result.txt");
			if (!resF.exists()) {
				resF.createNewFile();
			}
			BufferedReader br = new BufferedReader(new FileReader("data.txt"));

			while ((line = br.readLine()) != null) {
				if (i++ == 0) {
					nBits = Integer.parseInt(line);
				} else {
					newStr += line;
				}
			}
			PrintWriter pw = new PrintWriter(resF);
			pw.println ("" + doHash(newStr, nBits));
			pw.close();
			br.close();

		} catch (IOException e) {

		} finally {

		}

	}

}

class Input {

	private static Scanner in = new Scanner(System.in);

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
}
