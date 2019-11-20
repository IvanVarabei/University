package lab3.logic;

public class Angel {
	static final int PI_DIV2_CONV = 180;
//final
	public static double toRads(double degree) {
		return degree * Math.PI / PI_DIV2_CONV;
	}

	public static double toDegree(double radian) {
		return radian * PI_DIV2_CONV / Math.PI;
	}

}
