package by.bntu.fitr.varabei.javalabs.lab08.model;

public class Logic {
	private final static int DEFAULT = 0;
	private final static int TWICE=2;
	// First task
	public static double seekHypotenuse(double a, double b) {
		if (a > DEFAULT && b > DEFAULT)
			return Math.sqrt(Math.pow(a, TWICE) + Math.pow(b, TWICE));
		else {
			return DEFAULT;
		}
	}

	public static double seekTriangleSquare(double a, double b) {//90degrees
		if (a > DEFAULT && b > DEFAULT)
			return a * b / TWICE;
		else {
			return DEFAULT;
		}
	}

	public static double seekTrianglePerimetr(double a, double b) {//90degrees
		if (a > DEFAULT && b > DEFAULT)
			return a + b + seekHypotenuse(a, b);
		else {
			return DEFAULT;
		}
	}

	// Second task
	public static double seekRingSquare(double r1, double r2) {
		if (r1 > DEFAULT && r1 > r2)
			return Math.PI * (r1 * r1 - r2 * r2);
		else {
			return DEFAULT;
		}
		
	}

	// Third task
	public static double seekDistance(double x1, double y1, double x2, double y2) {
		return Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2));
	}

	// Forth task
	public static double seekRectungleSquare(double x1, double y1, double x2, double y2) {
		return Math.abs(x1 - x2) * Math.abs(y1 - y2);
	}

	public static double seekRectunglePerimetr(double x1, double y1, double x2, double y2) {
		return 2 * (Math.abs(x1 - x2) + Math.abs(y1 - y2));
	}

	// fifth task
	public static double seekTrianglePerimetr(double x1, double y1, double x2, double y2, double x3, double y3) {
		return seekDistance(x1, y1, x2, y2) + seekDistance(x2, y2, x3, y3) + seekDistance(x3, y3, x1, y1);
	}

	public static double seekTriangleSquare(double x1, double y1, double x2, double y2, double x3, double y3) {
		return 0.5 * Math.abs((x2 - x1) * (y3 - y1) - (x3 - x1) * (y2 - y1));
	}

	// Sixth task
	public static double seekBoatDistance(double t1, double t2, double u, double v) {
		return (u + v) * t1 + (v - u) * t2;
	}

	// Seventh
	public static double seekDistanceBetwinFacingCars(double v1, double v2, double s, double t) {
		double first = v1 * t, second = v2 * t;
		return Math.abs(s - first - second);
	}

	// Eighth
	public static double seekDistanceBetwinEscapingCars(double v1, double v2, double s, double t) {
		return v1 * t + v2 * t + s;
	}

	// Ninth
	public static double seekForesquarePerimetr(double a) {
		return a + a + a + a;
	}

	public static double seekForesquareSquare(double a) {
		return a * a;
	}

	// Tenth
	public static double seekRectangleSquare(double a, double b) {
		return a * b;
	}

	public static double seekRectunglePerimetr(double a, double b) {
		return a + a + b + b;
	}

	// Eleventh
	public static double seekLenthOfCercle(double a, boolean trueIfRadius) {
		double res = DEFAULT;
		if (trueIfRadius) {
			res = TWICE * Math.PI * a;
		} else {
			res = Math.PI * a / TWICE;
		}
		return res;
	}

	public static double seekSquareOfCercle(double a, boolean trueIfRadius) {
		double res = DEFAULT;
		if (trueIfRadius) {
			res = Math.PI * a * a;
		} else {
			res = Math.PI * a * a / TWICE/TWICE;
		}
		return res;
	}

}
