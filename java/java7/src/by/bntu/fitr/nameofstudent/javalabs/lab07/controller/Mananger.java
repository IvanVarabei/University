package by.bntu.fitr.nameofstudent.javalabs.lab07.controller;

import by.bntu.fitr.nameofstudent.javalabs.lab07.model.*;
import static by.bntu.fitr.nameofstudent.javalabs.lab07.view.Input.*;
import static by.bntu.fitr.nameofstudent.javalabs.lab07.view.Output.*;

import java.io.IOException;

public class Mananger {
	static public void main(String uoi[]) throws IOException {
		lable: while (true) {
			switch ((int) read("Menu laba7\nChoose number of methods \n" + "0 - Draco task\n1 - The Greatest\n"
					+ "2 - Mood Sensor \n" + "3 - Dice\n" + "4 - Consonant or vowel\n" + "5 - Extra task\n")) {
			case 0:
				Draco dragon = new Draco(readInt("Enter age of draco : "));
				exhibit("Your dragon has " + Draco.amountOfHeads + " heads.");
				exhibit("Your dragon has " + Draco.amountOfEyes + " eyes.");
				break;
			case 1:
				int a = readInt("Enter a:"), b = readInt("Enter a:"), c = readInt("Enter a:");
				exhibit("Is they are equals:" + Greatest.isEquals(a, b, c));
				exhibit("Max value:" + Greatest.seekMax(a, b, c));
				exhibit("Min value:" + Greatest.seekMin(a, b, c));
				break;
			case 2:
				exhibit("Your mood is " + Mood.determineSpirits());
				break;
			case 3:
				exhibit("Dice are throwed! " + Dice.throwDice());
				break;
			case 4:
				exhibit(""+Letter.determineLetter(readChar("Enter letter:")));
				break;
			case 5:
				exhibit("Next day:" + Leap.nextDay(readInt("Enter d.:"), readInt("Enter m.:"), readInt("Enter y.:")));
				break;
			default:
				break lable;
			}
		}

	}
}
