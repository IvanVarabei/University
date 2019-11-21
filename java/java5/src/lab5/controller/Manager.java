package lab5.controller;

import static lab4.utils.Input.*;
import static lab4.view.Output.*;
import static lab5.model.Numbers.*;
import static lab5.model.Square.*;

import lab5.model.CurrentDay;
import lab5.model.CurrentYear;
import lab5.model.Revers;

class Manager {

	static void task0() {

		exhibit(CurrentDay.showDate());
		exhibit("%d hours experied since start of day", CurrentDay.discoverHourNum());
		exhibit("%d minets experied since start of day", CurrentDay.discoverMinetsNum());
		exhibit("%d seconds experied since start of day", CurrentDay.discoverSecondsNum());
	}

	static void task1() {
	}

	static void task2() {
		int a = (int) read("Shove your number : ");
		exhibit("Approximetly ariphmetical=%.2f", approxArifm(a));
		exhibit("Approximetly giometrical=%.2f", approxGeom(a));
	}

	static void task3() {
		exhibit("Your reversed number=%d", Revers.doRev(readInt("Poke b : ")));
	}
	
	static void task4() {
		exhibit( CurrentYear.seekDay(readInt("Poke day : "), readInt("Poke month : ")));
	}


	static void task5() {
		int a = (int) read("Poke a : "), b = (int) read("Poke b : "), c = (int) read("Poke c : ");
		exhibit("This square can involve %d little squares", calcNumberSquares(a, b, c));
	}

	static void task6() {
	}

}
