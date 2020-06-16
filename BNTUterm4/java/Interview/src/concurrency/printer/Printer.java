package concurrency.printer;

import java.util.Random;
import java.util.concurrent.TimeUnit;

public class Printer {
	public static void main(String... sdf) {
		Printer p = new Printer();
		new Writer("first", p);
		new Writer("second", p);
		new Writer("third", p);
	}

	public Printer() {
		// TODO Auto-generated constructor stub
	}

	public void print(String s) {

		Random random = new Random();
		int time = random.nextInt(1000);
		try {
			System.out.print("[");
			TimeUnit.MILLISECONDS.sleep(time);
			for (char c : s.toCharArray()) {
				System.out.print(c);
				TimeUnit.MILLISECONDS.sleep(time);
			}

			System.out.println("]");
		} catch (Exception e) {

		}
	}

}
