package by.bntu.fitr.nameofstudent.javalabs.lab07.model;

class Draco {
	int age, amountOfHeads, amountOfEyes;
	final static int NIL = 0;
	final static int FIRST_STAP = 200;
	final static int SECOND_STEP = 300;
	final static int NATIV_AMOUNT = 3;
	final static int TWICE = 2;
	final int YU;

	public Draco(int n) {
		YU=n;
		age = n;
		amountOfHeads = seekHead();
		amountOfEyes = seekEyes();
	}

	public int seekHead() {
		int sum = NATIV_AMOUNT;
		for (int i = NIL; i < age; i++) {
			if (i < FIRST_STAP) {
				sum += NATIV_AMOUNT;
				continue;
			}
			if (i >= FIRST_STAP && i < SECOND_STEP) {
				sum++;
				sum++;
			} else {
				sum++;
			}
		}
		return sum;
	}

	public int seekEyes() {
		int sum = NATIV_AMOUNT;
		for (int i = NIL; i < age; i++) {
			if (i < FIRST_STAP) {
				sum += NATIV_AMOUNT;
				continue;
			}
			if (i >= FIRST_STAP && i < SECOND_STEP) {
				sum++;
				sum++;
			} else {
				sum++;
			}
		}
		return sum * TWICE;
	}
}
