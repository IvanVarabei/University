
package bntu.varabei.controller;

import static bntu.varabei.view.Output.*;
import static insert.Input.*;
import static model.ProcessingABC.*;

public class Launch {

	public static void main(String[] args) {
		shift: while (true) {
			switch (readInt("Menu lab 6\n0-triangle check\n1-rectangular triangle check\n2-isosce & rect check\n"
					+ "3-dot involving check\n4-seek quarter\n5-palindrom check\n6-subsequent check\n"
					+ "7-even odd check\n8-same odd or even check\n9-STOP\n")) {
			case 0:
				exhibit("Is it trangle:%b", isTriangle(readInt("a="), readInt("b="), readInt("c=")));
				break;
			case 1:
				exhibit("Is it rectangular:%b", isRectangular(readInt("a="), readInt("b="), readInt("c=")));
				break;
			case 2:
				exhibit("Is it isosce & rect:%b", isIsoscelesAndRect(read("a="), read("b="), read("c=")));
				break;
			case 3:
				exhibit("Is it involve:%b", isInvolve(readInt("x="), readInt("y="), readInt("x1="), readInt("y1="),
						readInt("x2="), readInt("y2=")));
				break;
			case 4:
				exhibit("Is it actual 1/4:%b", seekQuarter(readInt("n="), readInt("x="), readInt("y=")));
				break;
			case 5:
				exhibit("Is it palindrom:%b", palindrom(readInt("a=")));
				break;
			case 6:
				exhibit("Is it subsequent:%b", subsequent(readInt("a=")));
				break;
			case 7:
				exhibit("Most of it are even or odd:%b", evenOdd(readInt("a="), readInt("b="), readInt("c=")));
				break;
			case 8:
				exhibit("Is nubers with same odd or even:%b", sameEven(readInt("a="), readInt("b="), readInt("c=")));
				break;
			case 9:
				break shift;
			}
		}
	}
}
