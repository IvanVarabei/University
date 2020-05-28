package concurrency;

public class Sinhroniztion {
	
	public static void main(String ...wedf) throws InterruptedException {
		Resource r = new Resource();
		r.i =5;
		MyThread1 th1 = new MyThread1();
		th1.setName("one");
		MyThread1 th2 = new MyThread1();
		th1.setRes(r);
		th2.setRes(r);
		th1.start();
		th2.start();
		th1.join();
		th2.join();
		System.out.println(r.i);
	}

}

class MyThread1 extends Thread{
	Resource res;

	public Resource getRes() {
		return res;
	}

	public void setRes(Resource res) {
		this.res = res;
	}

	public void run() {
		res.change();
	}
}


class Resource{
	int i;
	public /*synchronized*/ void change() {
		synchronized(this) {
			int i = this.i;
			if(Thread.currentThread().getName().equals("one")) {
				Thread.yield();
			}
			i+=1;
			this.i = i;
		}	
	}
}
