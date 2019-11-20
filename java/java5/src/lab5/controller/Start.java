package lab5.controller;

import lab4.utils.Input;;

public class Start {
	public static void main(String[] args) {
		int choice;
		lable: while (true) {
			choice = (int) Input.read(
					"Menu laba5\nPush subsecuent buttens\nto carry out programs:\n"
					+ "0 - involved squares task\n1 - approximetly arifm. and geom. task\n2 - STOP\n");
			switch (choice) {
			case 0:
				Manager.task0();
				break;
			case 1:
				Manager.task1();
				break;
			case 2:
				break lable;
			}

		}
	}

}
