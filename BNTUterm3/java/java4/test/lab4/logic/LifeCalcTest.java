package lab4.logic;

import java.util.Calendar;
import java.util.GregorianCalendar;

import static org.junit.Assert.*;

import org.junit.Test;

import lab4.model.LifeCalc;

public class LifeCalcTest {
	GregorianCalendar calendar = new GregorianCalendar();

	@Test
	public void testCountAgeSeconds() {
		int d = calendar.get(Calendar.DAY_OF_MONTH), m = calendar.get(Calendar.MONTH) + 1,
				y = calendar.get(Calendar.YEAR), expRes = LifeCalc.countAgeSeconds(d, m, y);
		if (expRes != 0) {
			fail(); // TODO
		}
		d = d - 5;
		m = m - 1;
		y = y - 17;
		expRes = LifeCalc.countAgeSeconds(d, m, y);
		if (539_001_000 > expRes || expRes > 539_701_000) {
			fail("Not yet implemented");
		} // TODO }
	}

	@Test
	public void testCountAgeMinets() {
		int d = calendar.get(Calendar.DAY_OF_MONTH), m = calendar.get(Calendar.MONTH) + 1,
				y = calendar.get(Calendar.YEAR), expRes = LifeCalc.countAgeMinets(d, m, y);
		if (expRes != 0) {
			fail("Not yet implemented"); // TODO
		}
		d = d - 5;
		m = m - 1;
		y = y - 17;
		expRes = LifeCalc.countAgeMinets(d, m, y);
		if (8985400 > expRes || expRes > 8993800) {
			fail("Not yet implemented");
		} // TODO }
	}

	@Test
	public void testCountAgeHours() {
		int d = calendar.get(Calendar.DAY_OF_MONTH), m = calendar.get(Calendar.MONTH) + 1,
				y = calendar.get(Calendar.YEAR), expRes = LifeCalc.countAgeHours(d, m, y);
		if (expRes != 0) {
			fail("Not yet implemented"); // TODO
		}
		d = d - 5;
		m = m - 1;
		y = y - 17;
		expRes = LifeCalc.countAgeHours(d, m, y);
		if (149700 > expRes || expRes > 149800) {
			fail("Not yet implemented");
		} // TODO }

	}

	@Test
	public void testCountAgeDays() {
		int d = calendar.get(Calendar.DAY_OF_MONTH), m = calendar.get(Calendar.MONTH) + 1,
				y = calendar.get(Calendar.YEAR), expRes = LifeCalc.countAgeDays(d, m, y);
		if (expRes != 0) {
			fail("Not yet implemented"); // TODO
		}
		d = d - 5;
		m = m - 1;
		y = y - 17;
		expRes = LifeCalc.countAgeDays(d, m, y);
		if (6240 > expRes || expRes > 6250) {
			fail("Not yet implemented");
		} // TODO }

	}

	@Test
	public void testCountAgeWeeks() {
		int d = calendar.get(Calendar.DAY_OF_MONTH), m = calendar.get(Calendar.MONTH) + 1,
				y = calendar.get(Calendar.YEAR), expRes = LifeCalc.countAgeWeeks(d, m, y);
		if (expRes != 0) {
			fail("Not yet implemented"); // TODO
		}
		d = d - 5;
		m = m - 1;
		y = y - 17;
		expRes = LifeCalc.countAgeWeeks(d, m, y);
		if (893 < expRes || expRes < 888) {
			fail("Not yet implemented");
		} // TODO }

	}

	@Test
	public void testCountAgeMoanths() {
		int d = calendar.get(Calendar.DAY_OF_MONTH), m = calendar.get(Calendar.MONTH) + 1,
				y = calendar.get(Calendar.YEAR), expRes = LifeCalc.countAgeMoanths(d, m, y);
		if (expRes != 0) {
			fail("Not yet implemented"); // TODO
		}
		d = d - 5;
		m = m - 1;
		y = y - 17;
		expRes = LifeCalc.countAgeMoanths(d, m, y);
		if (205 > expRes || expRes > 210) {
			fail("Not yet implemented");
		} // TODO }
	}
}
