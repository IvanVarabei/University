package lab5.controller;

import static lab4.utils.Input.*;
import static lab4.view.Output.*;
import lab5.model.*;

class Manager {

	static void task0() {
		exhibit(CurrentDay.showDate());
		exhibit("%d hours experied since start of day", CurrentDay.discoverHourNum());
		exhibit("%d minets experied since start of day", CurrentDay.discoverMinetsNum());
		exhibit("%d seconds experied since start of day", CurrentDay.discoverSecondsNum());
	}

	static void task1() {
		int a = readInt("Shove your number : ");
		exhibit("Sum of figures = %d", Figure.summa(a));
		exhibit("Multiplication of figures = %d", Figure.miltiplication(a));
	}

	static void task2() {
		int a = (int) read("Shove your number : ");
		exhibit("Approximetly ariphmetical=%.2f", Numbers.approxArifm(a));
		exhibit("Approximetly giometrical=%.2f", Numbers.approxGeom(a));
	}

	static void task3() {
		exhibit("Your reversed number=%d", Revers.doRev(readInt("Poke fore digit number : ")));
	}

	static void task4() {
		exhibit(CurrentYear.seekDay(readInt("Poke day : "), readInt("Poke month : ")));
	}

	static void task5() {
		int a = readInt("Poke a : "), b = readInt("Poke b : "), c = readInt("Poke c : ");
		exhibit("This square can involve %d little squares", Square.calcNumberSquares(a, b, c));
	}

	static void task6() {
		exhibit("It is %d century.", Century.compute—enturies(readInt("Enter a year : ")));
	}

}
