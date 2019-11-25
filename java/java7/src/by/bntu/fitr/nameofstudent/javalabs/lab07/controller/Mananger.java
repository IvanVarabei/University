package by.bntu.fitr.nameofstudent.javalabs.lab07.controller;

import by.bntu.fitr.nameofstudent.javalabs.lab07.model.*;
import static by.bntu.fitr.nameofstudent.javalabs.lab07.view.Input.*;
import static by.bntu.fitr.nameofstudent.javalabs.lab07.view.Output.*;



public class Mananger {
	static public void main(String uoi[]) {
		lable: while (true) {
			switch ((int) read("Menu laba7\nChoose number of methods \n" + "0 - Draco task\n1 - The Greatest\n"
					+ "2 - Mood Sensor \n" + "3 - Dice\n" + "4 - Consonant or vowel\n" + "5 - Extra task\n")) {
			case 0:
				Draco dragon = new Draco(readInt("Enter age of draco : "));
				exhibit("Your dragon has " + Draco.amountOfHeads + " heads.");
				exhibit("Your dragon has " + Draco.amountOfEyes + " eyes.");
				break;
			case 1:
				break;
			case 2:
				break;
			case 3:
				break;
			case 4:
				break;
			case 5:
				break;
			default:
				break lable;
			}
		}

	}
}
