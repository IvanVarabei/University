package action;

import entity.Rectangle;
import entity.Triangle;
import static java.lang.Math.PI;

public class ActionMain {

	public static void main(String[] args) {
		IShapeAction action;
		try {
			Rectangle rectShape = new Rectangle(2, 3);
			action = new RectangleAction();
			System.out.println("Square rectangle: " + action.computeSquare(rectShape));
			System.out.println("Perimeter rectangle: " + action.computePerimeter(rectShape));
			Triangle trShape = new Triangle(3, 4, PI / 6);
			action = new TriangleAction();
			System.out.println("Square triangle: " + action.computeSquare(trShape));
			System.out.println("Perimeter triangle: " + action.computePerimeter(trShape));

			action.computePerimeter(rectShape); // ошибка времени выполнения
		} catch (IllegalArgumentException ex) {
			System.err.println(ex.getMessage());
		}
	}
}