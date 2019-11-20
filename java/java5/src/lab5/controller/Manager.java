package lab5.controller;

import static lab4.utils.Input.*;
import static lab4.view.Output.*;
import static lab5.model.Numbers.*;
import static lab5.model.Square.*;

class Manager {

	static void task0() {
		int a= (int) read("Poke a : "),b= (int) read("Poke b : "),c= (int) read("Poke c : ");
		exhibit("This square can involve %d little squares", calcNumberSquares(a, b, c));
	}

	static void task1() {
		int a=  (int)read("Shove your number : ");
		exhibit("Approximetly ariphmetical=%.2f", approxArifm(a));
		exhibit("Approximetly giometrical=%.2f", approxGeom(a));
	}

}
