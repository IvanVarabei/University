package lab4.controller;

import lab4.utils.Input;;

public class Start {
	public static void main(String[] args) {
		int choice;
		lable: while (true) {
			choice = (int) Input.read(
					"Menu\nPush subsecuent buttens\nto carry out programs:\n0 - general task\n1 - main task\n2 - STOP\n");
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
