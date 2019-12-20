package by.bntu.fitr.varabei.javalabs.lab09.controller;

import by.bntu.fitr.varabei.javalabs.lab09.model.*;

import static by.bntu.fitr.varabei.javalabs.lab09.view.Output.*;
import static by.bntu.fitr.varabei.javalabs.lab09.view.Input.*;


import java.io.IOException;

public class Mananger {
	static public void main(String uoi[]) throws IOException {
		lable: while (true) {
			switch (readChar("Menu laba9\nChoose number of task \n" + "a - Average arifm & geom\n"
					+ "b - Couple of figures in number\n" + "c - Reverse\n" + "d - Is prime number\n"
					+ "e - Show prime in order\n")) {
			case 'a':
				int a = readInt("Shove your number : ");
				exhibit("Approximetly ariphmetical= " + Numbers.approxArifm(a));
				exhibit("Approximetly giometrical= "+ Numbers.approxGeom(a));
				break;
			case 'b':
				a = readInt("Shove your number : ");
				exhibit("Is esists the couple of same figures : " + Figure.isSameFigures(a));
				break;
			case 'c':
				a = readInt("Shove your number : ");
				exhibit("Revers without last nils : " + Reverse.doReverse(a));
				break;
			case 'd':
				a = readInt("Shove your number : ");
				exhibit("Is it prime? : " + Prime.isPrime(a));
				break;
			case 'e':
				a = readInt("Shove number in subsequence : ");
				exhibit("It corresponds to : " + Prime.getPrimeByNumber(a));
				break;
			default:
				break lable;
			}
		}

	}
}
