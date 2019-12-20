package lab5.logic;

import static org.junit.Assert.*;
import org.junit.Test;
import lab5.model.Century;

public class CenturyTest {

	@Test
	public void testComputeÑenturies() {
		assertEquals(13,Century.computeÑenturies(1234));
		assertEquals(20,Century.computeÑenturies(1934));
		assertEquals(23,Century.computeÑenturies(2234));
	}

}
