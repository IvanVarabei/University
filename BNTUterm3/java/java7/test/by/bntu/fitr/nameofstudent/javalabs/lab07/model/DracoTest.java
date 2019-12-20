package by.bntu.fitr.nameofstudent.javalabs.lab07.model;

import static org.junit.Assert.*;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import by.bntu.fitr.varabei.javalabs.lab07.model.Draco;

public class DracoTest {

	private static Draco dragon1 = null;
	private static Draco dragon2 = null;
	private static Draco dragon3 = null;
	private static Draco dragon4 = null;
	private static Draco dragon5 = null;

	@BeforeClass
	public static void init() {
		dragon1 = new Draco(0);
		dragon2 = new Draco(1);
		dragon3 = new Draco(100);
		dragon4 = new Draco(240);
		dragon5 = new Draco(330);
		System.out.println("Before test");
	}

	@AfterClass
	public static void destroy() {
		dragon1 = null;
		dragon2 = null;
		dragon3 = null;
		dragon4 = null;
		dragon5 = null;
		System.out.println("After test");
	}

	@Test
	public void testSeekHead() {//10
		assertEquals(3, dragon1.amountOfHeads);
		assertEquals(6, dragon2.amountOfHeads);
		assertEquals(303, dragon3.amountOfHeads);
		assertEquals(683, dragon4.amountOfHeads);
		assertEquals(833, dragon5.amountOfHeads);
	}

	@Test
	public void testSeeëkEyes() {
		assertEquals(6, dragon1.amountOfEyes);
		assertEquals(12, dragon2.amountOfEyes);
		assertEquals(606, dragon3.amountOfEyes);
		assertEquals(1366, dragon4.amountOfEyes);
		assertEquals(1666, dragon5.amountOfEyes);
	}

}
