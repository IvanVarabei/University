package action;

import entity.AbstractShape;
import entity.Triangle;

public class TriangleAction implements IShapeAction {
	@Override
	public double computeSquare(AbstractShape shape) {
		double square = 0;
		if (shape instanceof Triangle) {
			Triangle triangle = (Triangle) shape;
			square = 1 / 2 * triangle.getA() * triangle.getB() * Math.sin(triangle.getAngle());
		} else {
			throw new IllegalArgumentException("Incompatible shape" + shape.getClass());
		}
		return square;
	}

	@Override
	public double computePerimeter(AbstractShape shape) {
		double perimeter = 0;
		if (shape instanceof Triangle) {
			Triangle triangle = (Triangle) shape;
			perimeter = triangle.getA() + triangle.getB() + triangle.getC();
		} else {
			throw new IllegalArgumentException("Incompatible shape" + shape.getClass());
		}
		return perimeter;

	}
}
