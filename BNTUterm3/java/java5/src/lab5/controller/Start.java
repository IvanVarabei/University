package lab5.controller;

import lab4.utils.Input;;

public class Start {
	public static void main(String[] args) {
		int choice;
		lable: while (true) {
			choice = Input.readInt("Menu laba5\nChoose number of methods \n"
					+ "0 - Considers seconds, minets, hours\n1 - Find amount, multiplication\n" +
					"2 - Appreximetly arithmetic and geometric \n"+
					"3 - Revers\n"+
					"4 - Determine number\n"+
					"5 - Find number of squares\n"+
					"6 - Define a century\n7 - Stop");
			switch (choice) {
			case 0:
				Manager.task0();
				break;
			case 1:
				Manager.task1();
				break;
			case 2:
				Manager.task2();
				break;
			case 3:
				Manager.task3();
				break;
			case 4:
				Manager.task4();
				break;
			case 5:
				Manager.task5();
				break;
			case 6:
				Manager.task6();
				break;
			case 7:
				break lable;
			}

		}
	}

}
