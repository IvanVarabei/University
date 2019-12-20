package by.bntu.fitr.varabei.javalabs.lab08.controller;

import java.lang.*;
import static by.bntu.fitr.varabei.javalabs.lab08.view.Input.*;
import static by.bntu.fitr.varabei.javalabs.lab08.view.Output.*;
import static by.bntu.fitr.varabei.javalabs.lab08.model.Logic.*;
import java.io.IOException;

public class Mananger {
	static public void main(String uoi[]) throws IOException {
		lable: while (true) {
			switch (readInt("Menu laba8\nChoose number of task \n" + "1 - Hypotenuse, perimetr, square\n"
					+ "2 - Ring square\n" + "3 - Distance between two dots\n" + "4 - Square & perimetr of rect\n"
					+ "5 - Square & perimetr of treangle\n6 - Boat task\n")) {
			case 1:
				double a = readD("Enter first cathet : "), b = readD("Enter second cathet : ");
				exhibit("Hypotenuse : " + seekHypotenuse(a, b));
				exhibit("Perimetr : " + seekTrianglePerimetr(a, b));
				exhibit("Square : " + seekTriangleSquare(a, b));
				break;
			case 2:
				exhibit("" + seekRingSquare(readD("Enter first radious : "), readD("Enter second radious : ")));
				break;
			case 3:
				exhibit("Distence : " + seekDistance(readD("Enter x1: "), readD("Enter y1: "), readD("Enter x2: "),
						readD("Enter y2: ")));
				break;
			case 4:
				double x1 = readD("Enter x1: "), y1 = readD("Enter y1: "), x2 = readD("Enter x2: "),
						y2 = readD("Enter y2: ");
				exhibit("Rect. square : " + seekRectungleSquare(x1, y1, x2, y2));
				exhibit("Rect. perimetr : " + seekRectunglePerimetr(x1, y1, x2, y2));
				break;
			case 5:
				x1 = readD("Enter x1: ");
				y1 = readD("Enter y1: ");
				x2 = readD("Enter x2: ");
				y2 = readD("Enter y2: ");
				double x3 = readD("Enter x2: "), y3 = readD("Enter y2: ");
				exhibit("Perimetr : " + seekTrianglePerimetr(x1, y1, x2, y2, x3, y3));
				exhibit("Square : " + seekTriangleSquare(x1, y1, x2, y2, x3, y3));
				break;
			case 6:
				exhibit("Distance treveled : " + seekBoatDistance(readD("Enter t1: "), readD("Enter t2: "),
						readD("Enter rever speed: "), readD("Boat speed : ")));
				break;
			default:
				break lable;
			}
		}

	}
}
