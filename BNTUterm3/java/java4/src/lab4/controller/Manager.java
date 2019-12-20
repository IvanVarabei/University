package lab4.controller;

import lab4.model.*;
import lab4.utils.*;
import lab4.view.*;

class Manager {

	static void task0() {
		double birthDay = Input.read("Input your day of berth : "),
				birthMonth = Input.read("Input your manth of berth : "),
				birthYear = Input.read("Input your year of berth : ");
		Output.exhibit("You have lived approximetly %d seconds",
				LifeCalc.countAgeSeconds(birthDay, birthMonth, birthYear));
		Output.exhibit("You have lived approximetly %d minets",
				LifeCalc.countAgeMinets(birthDay, birthMonth, birthYear));
		Output.exhibit("You have lived approximetly %d hours", LifeCalc.countAgeHours(birthDay, birthMonth, birthYear));
		Output.exhibit("You have lived approximetly %d days", LifeCalc.countAgeDays(birthDay, birthMonth, birthYear));
		Output.exhibit("You have lived approximetly %d weeks", LifeCalc.countAgeWeeks(birthDay, birthMonth, birthYear));
		Output.exhibit("You have lived approximetly %d moanths",
				LifeCalc.countAgeMoanths(birthDay, birthMonth, birthYear));

	}

	static void task1() {
		Output.exhibit(Artist.paintTiny());
		Output.exhibit(Artist.paintNormal());
		Output.exhibit(Artist.paintEnormus());
	}

}
