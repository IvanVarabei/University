package linux11;

import java.io.IOException;
import java.util.Random;

public class Threads {

	static public StringBuffer str = new StringBuffer("hello");
	static public StringBuffer res = new StringBuffer("");
	static String ms = "qwertyuiop[asdfghjkl;'zxcvbnm,./";
	static String r = "";
	
	static int rand(int from, int to) {
		Random r = new Random();
		return  r.nextInt(to - from + 1) + from;
	}

	public static void main(String... fd) {		
		Thread shifter = new Thread(new Runnable() {
			@Override
			public synchronized void run() {
				while (true) {
					System.out.println(res.toString() + str);
					res.insert(0, ' ');
					try {
						Thread.sleep(500);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		});

		Thread contentChanger = new Thread( new Runnable() {
			
			public synchronized void run() {
				while(true) {
					str.deleteCharAt(rand(0,str.length()-1));
					str.insert(rand(0,str.length()-1),ms.charAt(rand(0,ms.length()-1)));
					try {
						Thread.sleep(500);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		});
		
		Thread upLow = new Thread(new Runnable() {
			@Override
			public synchronized void run() {
				while(true) {
					int i = rand(0,str.length()-2);
					char c = str.charAt(i);
					if(rand(0,1)==1) {
						str.setCharAt(i, Character.toLowerCase(c));
					}
					else {
						str.setCharAt(i, Character.toUpperCase(c));
					}
					try {
						Thread.sleep(500);
					} catch (InterruptedException e) {
						e.printStackTrace();
				
					}
					
				}
			}
		});
		
		shifter.start();
		upLow.start();
		contentChanger.start();
	}

}
