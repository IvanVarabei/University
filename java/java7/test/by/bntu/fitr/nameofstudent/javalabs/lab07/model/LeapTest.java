package by.bntu.fitr.nameofstudent.javalabs.lab07.model;

import static org.junit.Assert.*;

import org.junit.Test;

import by.bntu.fitr.varabei.javalabs.lab07.model.Leap;

public class LeapTest {

	@Test
	public void testIsMultiple() {
		assertEquals(true,Leap.isMultiple(-8,-4));
		assertEquals(false,Leap.isMultiple(9,4));
	}

	@Test
	public void testIsBissextile() {
		assertEquals(true,Leap.isBissextile(2008));
		assertEquals(true,Leap.isBissextile(2012));
		assertEquals(true,Leap.isBissextile(1600));
		assertEquals(false,Leap.isBissextile(2009));
		assertEquals(false,Leap.isBissextile(2019));
		assertEquals(true,Leap.isBissextile(2020));
	}

	@Test
	public void testNextDay() {
		assertEquals("18.10.2019",Leap.nextDay(17,10,2019));
		assertEquals("1.1.2020",Leap.nextDay(31,12,2019));
		assertEquals("1.3.2019",Leap.nextDay(28,2,2019));
		assertEquals("29.2.2020",Leap.nextDay(28,2,2020));
		assertEquals("1.3.2020",Leap.nextDay(29,2,2020));
		assertEquals("Input error",Leap.nextDay(29,2,-2020));
		assertEquals("Input error",Leap.nextDay(29,2,2021));
	}

}
