package concurrency;

public class SecondThread implements Runnable{

	int num;
	Thread thread;
	
	public SecondThread(int n) {
		num = n;
		ThreadGroup tg = new ThreadGroup("new Group");
		thread = new Thread(tg,this);
		thread.start();
	}

	@Override
	public void run() {
		while(true) {
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			};
			System.out.printf("%d - runnable\n", num);
		}
	}

}
