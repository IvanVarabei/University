package arrays;

public class Tsk {

	public static void main(String... fd) {
		//printStars(0);
		reverse(12399);
		System.out.println(countDigit(1));
		//System.out.println(pow(1,0));
		System.out.println(reverse(123));
	}

	public static void printStars(int n) {
		for(int i =n; i>0; i--) {
			for(int j =0; j < i; j++)
				System.out.print("*");
			System.out.println();
		}
		
	}
	
	public static int countDigit(int n) {
		int result = 0;
		while(n>0) {
			result++;
			n /=10;
		}
		return result;
	}
	
	static long pow(long a, long b) {
		long res = 1;
		for (long i = 1; i <= b; i++) {
			res *= a;
		}
		return res;
	}
	
	public static int reverse(int n) {
		int result = 0, digits = countDigit(n);
		int tens = (int)pow(10,digits);
		
		for(int i =digits; i>=0; i-- ) {
			if(n<10) {
				result+=n;
				break;
			}
			result += (n%10) * pow(10,i-1);
			n /=10;
		}
		return result;
	}

}
