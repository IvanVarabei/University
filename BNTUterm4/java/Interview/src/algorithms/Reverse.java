package algorithms;

public class Reverse {

	public static void main(String ...sdf) {
		System.out.println(reverse(123));
	}
	
	static int pow(int base, int extent) {
		int result = 1;
		for(int i =0; i<extent; i++) {
			result*=base;
		}
		return result;
	}
	
	static int figureOutNumberOfDigits(int n) {
		int result = 0;
		while(n>0) {
			n/=10;
			result ++;
		}
		return result;
	}
	
	static int reverse(int n) {
		int result = 0;
		int digits = figureOutNumberOfDigits(n);
		for(int i = digits; i>0;i--) {
			result += (n%10) * pow(10, i-1);
			n/=10;
		}
		return result;
	}

}
