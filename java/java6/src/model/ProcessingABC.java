package model;

public class ProcessingABC {
	final static int FIRST_Q = 1;
	final static int SECOND_Q = 2;
	final static int THERD_Q = 3;
	final static int FERTHS_Q = 4;
	final static int NIL = 0;
	final static int THAUTH_DIV = 1000;
	final static int HANDR_DIV = 100;
	final static int HAND_DIV = 10;
	final static int ODD_OR_EVEN = 2;
	final static int STRAIGHT = 2;

	public static boolean isTriangle(int a, int b, int c) {
		return a >= b && a >= c && a <= c + b || b >= a && b >= c && b <= c + a || c >= b && c >= a && c <= b + a;
	}

	public static boolean isRectangular(int a, int b, int c) {
		return a > b && a > c && a * a == c * c + b * b || b > a && b > c && b * b == c * c + a * a
				|| c > b && a < c && c * c == b * b + a * a;
	}

	public static boolean isIsoscelesAndRect(double a, double b, double c) {
		return a > b && a > c && a < c + b && c == b && Math.sqrt(STRAIGHT) * c == a
				|| b > a && b > c && b < c + a && a == c && Math.sqrt(STRAIGHT) * c == b
				|| c > b && a < c && c < b + a && a == b && Math.sqrt(STRAIGHT) * a == c;
	}

	public static boolean isInvolve(int x, int y, int x1, int y1, int x2, int y2) {
		return x1 < x && x < x2 && y1 > y && y > y2;
	}

	public static boolean seekQuarter(int n, int x, int y) {
		return n == FIRST_Q && x > NIL && y > NIL || n == SECOND_Q && x < NIL && y > NIL
				|| n == THERD_Q && x < NIL && y < NIL || n == FERTHS_Q && x > NIL && y < NIL;
	}

	public static boolean isPalindrom(int z) {
		int a = z / THAUTH_DIV, b = z % THAUTH_DIV / HANDR_DIV, c = z % HANDR_DIV / HAND_DIV, d = z % HAND_DIV;
		return a == d && b == c;
	}

	public static boolean isSubsequent(int z) {
		int a = z / THAUTH_DIV, b = z % THAUTH_DIV / HANDR_DIV, c = z % HANDR_DIV / HAND_DIV, d = z % HAND_DIV;
		return a > b && b > c && c > d || a < b && b < c && c < d;
	}

	public static boolean areEvenPrevail(int a, int b, int c) {
		return a % ODD_OR_EVEN == NIL && b % ODD_OR_EVEN == NIL || c % ODD_OR_EVEN == NIL && a % ODD_OR_EVEN == NIL
				|| c % ODD_OR_EVEN == NIL && b % ODD_OR_EVEN == NIL;
	}

	public static boolean areAllEven(int a, int b, int c) {
		return a % ODD_OR_EVEN == b % ODD_OR_EVEN && a % ODD_OR_EVEN == c % SECOND_Q
				|| a % ODD_OR_EVEN != b % ODD_OR_EVEN && a % ODD_OR_EVEN != c % SECOND_Q;
	}

}
