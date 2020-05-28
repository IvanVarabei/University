package concurrency;

import java.util.concurrent.TimeUnit;

public class Test {

	public static void main(String ...dfsg) throws InterruptedException {
		
		MyThread st = new MyThread();
		System.out.println("state:"+st.thread.getState());
		st.getThread().start();
		System.out.println("state:"+st.thread.getState());

		TimeUnit.SECONDS.sleep(3);
		st.stop();
		
	}

}
