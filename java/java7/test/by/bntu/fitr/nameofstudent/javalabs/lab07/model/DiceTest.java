package by.bntu.fitr.nameofstudent.javalabs.lab07.model;

import static org.junit.Assert.*;

import org.junit.Test;

public class DiceTest {

	@Test
	public void testThrowDice() {
		boolean flag2 = false, flag12 = false;
		for (int i = 0; i < 300; i++) {
			if (Dice.throwDice() > 12 || Dice.throwDice() < 2) {
				fail();
			}
			if (Dice.throwDice() == 12) {
				flag12 = true;
			}
			if (Dice.throwDice() == 2) {
				flag2 = true;
			}
		}
		if (!flag2 || !flag12) {
			fail();
		}
	}

}
