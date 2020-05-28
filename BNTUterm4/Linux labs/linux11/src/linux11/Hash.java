package linux11;

import java.util.Scanner;
import java.io.*;

public class Hash {
	
public static void main(String[] ms)  {
		
		Reader reader = new Reader();
		Thread readThread = new Thread(reader);
		readThread.start();
		try {
			readThread.join();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		new Writer(reader.getnBits(), reader.getNewStr()).start();

	}

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

}

class Reader implements Runnable {

	int nBits = 0;
	String newStr = "";
	String line;
	int i = 0;

	public int getnBits() {
		return nBits;
	}

	public String getNewStr() {
		return newStr;
	}

	@Override
	public void run() {
		try {
			BufferedReader br = new BufferedReader(new FileReader("data.txt"));
			while ((line = br.readLine()) != null) {
				if (i++ == 0)
					nBits = Integer.parseInt(line);
				else
					newStr += line;
			}
			br.close();
		} catch (Exception e) {

		}

	}
}

class Writer extends Thread {
	int nBits;
	String newStr;

	public Writer(int nBits, String newStr) {
		super();
		this.nBits = nBits;
		this.newStr = newStr;
	}

	@Override
	public void run() {
		try {
			File resF = new File("result.txt");
			if (!resF.exists())
				resF.createNewFile();
			PrintWriter pw = new PrintWriter(resF);
			
			class R implements Runnable {
				long s;
				
				public long getS() {return s;}
				
				@Override
				public void run() {
					s = Hash.doHash(newStr, nBits);
				}
			};
			R count = new R();
			Thread countThread = new Thread(count);
			
			countThread.start();
			countThread.join();
			
			pw.println("" + count.getS() );
			pw.close();
		} catch (Exception e) {
		}
	}
}
