package lab3.controller;
import lab3.utils.*;

public class Start {
	public static void main(String[] args) {
		int choice;
		lable: while (true) {

			choice = (int) Input.read("Menu\n0 to general task\n1 to dino task\n" + "2 to converter task\n"
					+ "3 to distance task\n4 to change task\n" + "5 to costs task\n6 to cancel programm");
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
				break lable;
			}

		}
	}

}
