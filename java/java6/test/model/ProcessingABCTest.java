package model;

import static org.junit.Assert.*;

import org.junit.Test;

public class ProcessingABCTest {

	@Test
	public void testisTriangle() {
		assertEquals(true, ProcessingABC.isTriangle(1, 1, 1));
		assertEquals(true, ProcessingABC.isTriangle(2, 100, 101));
		assertEquals(false, ProcessingABC.isTriangle(11, 1, 1));
		assertEquals(false, ProcessingABC.isTriangle(1, 11, 1));
		assertEquals(false, ProcessingABC.isTriangle(1, 1, 11));
		assertEquals(false, ProcessingABC.isTriangle(12, 5, 27));
	}

	@Test
	public void testIsRectangular() {
		assertEquals(false, ProcessingABC.isRectangular(1, 1, 1));
		assertEquals(true, ProcessingABC.isRectangular(6, 8, 10));
	}

	@Test
	public void testIsIsoscelesAndRect() {
		assertEquals(false, ProcessingABC.isIsoscelesAndRect(1, 1, 1));
		assertEquals(false, ProcessingABC.isIsoscelesAndRect(1, 1, 1.3));
		assertEquals(true, ProcessingABC.isIsoscelesAndRect(Math.sqrt(2),1,1));
		assertEquals(true, ProcessingABC.isIsoscelesAndRect(Math.sqrt(2)*2,2,2));
		assertEquals(true, ProcessingABC.isIsoscelesAndRect(3, 3, 3*Math.sqrt(2)));
		assertEquals(false, ProcessingABC.isIsoscelesAndRect(4, Math.sqrt(18),3));
	}

	@Test
	public void testIsInvolve() {
		assertEquals(true, ProcessingABC.isInvolve(1, 1, 0, 6, 9, -9));
		assertEquals(false, ProcessingABC.isInvolve(1, 10, 0, 6, 9, -9));
	}

	@Test
	public void testSeekQuarter() {
		assertEquals(true, ProcessingABC.seekQuarter(1, 1, 1));
		assertEquals(true, ProcessingABC.seekQuarter(4, 1, -1));
		assertEquals(false, ProcessingABC.seekQuarter(1, -1, -1));
		assertEquals(true, ProcessingABC.seekQuarter(2, -1, 1));
		assertEquals(true, ProcessingABC.seekQuarter(3, -1, -1));
	}

	@Test
	public void testPalindrom() {
		assertEquals(true, ProcessingABC.palindrom(1991));
		assertEquals(false, ProcessingABC.palindrom(9787));
	}
	@Test
	public void testSubsequent() {
		assertEquals(true, ProcessingABC.subsequent(1234));
		assertEquals(true, ProcessingABC.subsequent(9742));
		assertEquals(false, ProcessingABC.subsequent(9787));
	}
	@Test
	public void testEvenOdd() {
		assertEquals(true, ProcessingABC.evenOdd(4,6,8));
		assertEquals(false, ProcessingABC.evenOdd(5,7,9));
		assertEquals(false, ProcessingABC.evenOdd(1,2,3));
		assertEquals(true, ProcessingABC.evenOdd(8,2,3));
		
	}
	@Test
	public void testSameEven() {
		assertEquals(true, ProcessingABC.sameEven(4,6,8));
		assertEquals(true, ProcessingABC.sameEven(5,7,9));
		assertEquals(false, ProcessingABC.sameEven(5,8,9));
	}

}
