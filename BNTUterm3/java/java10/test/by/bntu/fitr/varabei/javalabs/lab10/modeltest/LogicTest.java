package by.bntu.fitr.varabei.javalabs.lab10.modeltest;

import static org.junit.Assert.*;
import static by.bntu.fitr.varabei.javalabs.lab10.model.Logic.*;
import org.junit.Test;

public class LogicTest {

	private static void assertDoubleEquals(double a, double b) {
		if (Math.round(a * 100.0) / 100.0 != Math.round(b * 100.0) / 100.0) {
			fail();
		}
	}

	@Test
	public void testMuliplicateNegBefre() {
		assertDoubleEquals(12, muliplicateNegBefre(3, -6, 0, 9, -2, 7, 22, -5, 0));
	}

	@Test
	public void testSumPosBefre() {
		assertDoubleEquals(19, sumPosBefre(3, -6, 0, 9, -2, 7, 22, -5, 0));
	}

	@Test
	public void testGetMaxPos() {
		assertEquals(6, getMaxPos(3, -6, 0, 9, -2, 7, 22, -5, 0));
	}

}
