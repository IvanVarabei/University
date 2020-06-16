package concurrency;

public class FirstThread extends Thread{

	int number;
	
	public FirstThread(int n) {
		number = n;
		start();
	}
	
	public void run() {
		while(true) {
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.printf("%d - child\n", number);
		}
	}

}
