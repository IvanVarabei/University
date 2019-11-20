package lab5.logic;

import static org.junit.Assert.*;

import org.junit.Test;

import lab5.model.Square;

public class SquareTest {

	@Test
	public void test() {
	int expected=Square.calcNumberSquares(3, 9, 8), actual=6;
		assertEquals(expected, actual);
	}

}
