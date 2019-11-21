package lab5.logic;

import static org.junit.Assert.*;

import org.junit.Test;

import lab5.model.Figure;

public class FigureTest {

	@Test
	public void testSumma() {
		assertEquals(13,Figure.summa(67));
		assertEquals(22,Figure.summa(6709));
		assertEquals(7,Figure.summa(1111111));
	}
	
	@Test
	public void testMiltiplication() {
		assertEquals(42,Figure.miltiplication(67));
		assertEquals(0,Figure.miltiplication(6709));
		assertEquals(1,Figure.miltiplication(1111111));
	}

}
