package by.bntu.fitr.varabei.javalabs.lab09.model;

import static org.junit.Assert.*;

import org.junit.Test;

public class ReverseTest {

	@Test
	public void testFigureOutNils() {
		assertEquals(2,Reverse.figureOutNils(4270600,7));
	}

	@Test
	public void testAssembly() {
		assertEquals(4270600,Reverse.assembly(4,2,7,0,6,0,0));
	}

	@Test
	public void testDoReverse1() {
		assertEquals(123400,Reverse.doReverse(432100));
	}
	
	@Test
	public void testDoReverse2() {
		assertEquals(100,Reverse.doReverse(100));
	}
	
	@Test
	public void testDoReverse3() {
		assertEquals(1,Reverse.doReverse(1));
	}
	
	@Test
	public void testDoReverse4() {
		assertEquals(420024500,Reverse.doReverse(542002400));
	}


}
