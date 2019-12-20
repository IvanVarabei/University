package by.bntu.fitr.varabei.javalabs.lab08.modelTest;

import static org.junit.Assert.*;

//import by.bntu.fitr.varabei.javalabs.lab08.model.Logic.*;

import org.junit.Test;

import by.bntu.fitr.varabei.javalabs.lab08.model.Logic;

public class LogicTest {
	
	private static void assertDoubleEquals(double a, double b) {
		if (Math.round(a * 100.0) / 100.0 != Math.round(b * 100.0) / 100.0) {
			fail();
		}
	}

	@Test
	public void testSeekHypotenuse1() {
		assertDoubleEquals(10,Logic.seekHypotenuse(6,8));
	}
	
	@Test
	public void testSeekHypotenuse2() {
		assertDoubleEquals(0,Logic.seekHypotenuse(-6,8));
	}

	@Test
	public void testSeekTriangleSquareDoubleDouble1() {//90degrees
		assertDoubleEquals(24,Logic.seekTriangleSquare(6,8));
	}
	@Test
	public void testSeekTriangleSquareDoubleDouble2() {//90degrees
		assertDoubleEquals(0,Logic.seekTriangleSquare(6,-8));
	}

	@Test
	public void testSeekTrianglePeimetr1() {//90degrees
		assertDoubleEquals(24,Logic.seekTrianglePerimetr(6,8));
	}
	
	@Test
	public void testSeekTrianglePeimetr2() {//90degrees
		assertDoubleEquals(0,Logic.seekTrianglePerimetr(-0.99,8));
	}

	@Test
	public void testSeekRingSquare1() {
		assertDoubleEquals(15.707,Logic.seekRingSquare(3,2));
	}
	
	@Test
	public void testSeekRingSquare2() {
		assertDoubleEquals(0,Logic.seekRingSquare(3,9));
	}

	@Test
	public void testSeekDistance() {
		assertDoubleEquals(10,Logic.seekDistance(8,0,0,6));
	}

	@Test
	public void testSeekRectungleSquare() {
		assertDoubleEquals(48,Logic.seekRectungleSquare(6,0,0,8));
	}

	@Test
	public void testSeekRectunglePerimetr() {
		assertDoubleEquals(28,Logic.seekRectunglePerimetr(6,0,0,8));
	}

	@Test
	public void testSeekTrianglePerimetr() {
		assertDoubleEquals(24,Logic.seekTrianglePerimetr(0,0,0,6,8,0));
	}

	@Test
	public void testSeekTriangleSquare() {
		assertDoubleEquals(24,Logic.seekTriangleSquare(0,0,0,6,8,0));
	}

	@Test
	public void testSeekBoatDistance() {
		assertDoubleEquals(28,Logic.seekBoatDistance(1,2,2,10));
	}

	@Test
	public void testSeekDistanceBetwinFacingCars() {
		assertDoubleEquals(10,Logic.seekDistanceBetwinFacingCars(10,20,100,3));
	}

	@Test
	public void testSeekDistanceBetwinEscapingCars() {
		assertDoubleEquals(190,Logic.seekDistanceBetwinEscapingCars(10,20,100,3));
	}

	@Test
	public void testSeekForesquarePerimetr() {
		assertDoubleEquals(32,Logic.seekForesquarePerimetr(8));
	}

	@Test
	public void testSeekForesquareSquare() {
		assertDoubleEquals(64,Logic.seekForesquareSquare(8));
	}

	@Test
	public void testSeekRectangleSquare() {
		assertDoubleEquals(48,Logic.seekRectangleSquare(6,8));
	}

	@Test
	public void testSeekRectunglePerimetrDoubleDouble() {
		assertDoubleEquals(28,Logic.seekRectunglePerimetr(6,8));
	}

	@Test
	public void testSeekLenthOfCercle() {
		assertDoubleEquals(50.265,Logic.seekLenthOfCercle(8,true));
	}

	@Test
	public void testSeekSquareOfCercle() {
		assertDoubleEquals(201.06,Logic.seekSquareOfCercle(8,true));
	}

}
