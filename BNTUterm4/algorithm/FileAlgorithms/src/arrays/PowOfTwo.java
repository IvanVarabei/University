package arrays;

import java.util.Arrays;

public class PowOfTwo {

	public static void main(String... fdsf) {
		int ms[] = { 0, 8, 5, 67, 4, 3, 88, 32, 9 };
		System.out.println("Powers of 2 :\n" + Arrays.toString(ms));
		print(ms);
	}

	public static void print(int[] ms) {
		for (int p : ms) {
			if(isPower2(p)) {
				System.out.println(p);
			}
		}
	}
	
	static boolean isPower2(int n) {
		if(n<=0)
			return false;
		while(n>1) {
			if(n%2!=0) 
				return false;
			n/=2;	
		}
		return true;
	}
}
