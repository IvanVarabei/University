package lab5.logic;

import static org.junit.Assert.*;

import org.junit.Test;

import lab5.model.CurrentYear;

public class CurrentYearTest {

	@Test
	public void testSeekDay() {
		assertEquals("TUESDAY",CurrentYear.seekDay(1, 1));
		assertEquals("THURSDAY",CurrentYear.seekDay(21, 11));
		assertEquals("MONDAY",CurrentYear.seekDay(7, 10));
		assertEquals("SUNDAY",CurrentYear.seekDay(29, 9));
		assertEquals("WEDNESDAY",CurrentYear.seekDay(14, 8));
	}

	@Test
	public void testSeekNumberOfDayInYear() {
		assertEquals(1,CurrentYear.seekNumberOfDayInYear(1, 1));
		assertEquals(15,CurrentYear.seekNumberOfDayInYear(15, 1));
		assertEquals(365,CurrentYear.seekNumberOfDayInYear(31, 12));
	}

}
