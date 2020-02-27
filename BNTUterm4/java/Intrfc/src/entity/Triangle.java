package entity;

public class Triangle extends AbstractShape {
	private double b;
	private double angle; // угол между сторонами в радианах

	public Triangle(double a, double b, double angle) {
		super(a);
		this.b = b;
		this.angle = angle;
	}

	public double getAngle() {
		return angle;
	}

	public double getB() {
		return b;
	}


	public double getC() {
		double c = Math.sqrt(b * b + super.getA() * super.getA() * -2 * b * super.getA() * Math.cos(angle));
		return c;
	}
}