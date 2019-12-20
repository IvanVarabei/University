package by.bntu.fitr.varabei.javalabs.lab09.model;

import static org.junit.Assert.*;

import org.junit.Test;

public class FigureTest {

	@Test
	public void testIsSameFigures1() {
		assertEquals(true,Figure.isSameFigures(13241));
	}
	
	@Test
	public void testIsSameFigures2() {
		assertEquals(false,Figure.isSameFigures(1234567));
	}
	
	@Test
	public void testIsSameFigures3() {
		assertEquals(true,Figure.isSameFigures(33));
	}
	
	@Test
	public void testIsSameFigures4() {
		assertEquals(false,Figure.isSameFigures(3));
	}
	
	@Test
	public void testIsSameFigures5() {
		assertEquals(true,Figure.isSameFigures(99887700));
	}

}
