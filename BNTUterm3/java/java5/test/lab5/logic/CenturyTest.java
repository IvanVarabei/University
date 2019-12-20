package lab5.logic;

import static org.junit.Assert.*;
import org.junit.Test;
import lab5.model.Century;

public class CenturyTest {

	@Test
	public void testCompute�enturies() {
		assertEquals(13,Century.compute�enturies(1234));
		assertEquals(20,Century.compute�enturies(1934));
		assertEquals(23,Century.compute�enturies(2234));
	}

}
