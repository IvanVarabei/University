package concurrency.printer;

import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class Writer implements Runnable {
	private String text;
	private Printer printer;
	private Thread thread;
	static Lock lock = new ReentrantLock();

	public Writer(String text, Printer printer) {
		this.text = text;
		this.printer = printer;
		thread = new Thread(this);
		thread.start();
	}

	@Override
	public void run() {
		while (true) {
			if (lock.tryLock()) {
				printer.print(text);
				lock.unlock();
				break;
			}
			try {
				TimeUnit.MILLISECONDS.sleep(1800);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			System.out.println("\n" + text + " is doing something other");
		}
	}

}
