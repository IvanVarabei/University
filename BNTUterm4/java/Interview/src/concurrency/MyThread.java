package concurrency;

import java.util.concurrent.TimeUnit;

public class MyThread implements Runnable{

	Thread thread;
	private boolean running = true;
	
	public MyThread() {
		thread = new Thread(this);
	}
	
	public Thread getThread() {
		return thread;
	}
	
	public void stop() {
		running = false;
	}

	@Override
	public void run() {
		while(running) {
		try {
			System.out.println("Child is running");
			TimeUnit.MILLISECONDS.sleep(500);;
		}
		catch(Exception e) {
			
		}
		
	}
	}

}
