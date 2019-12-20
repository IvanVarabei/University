package lab5.logic;

import static org.junit.Assert.*;

import org.junit.Test;

import lab5.model.Revers;

public class ReversTest {

	@Test
	public void testDoRev() {
		assertEquals(1234,Revers.doRev(4321));
		assertEquals(6789,Revers.doRev(9876));
		assertEquals(1023,Revers.doRev(3201));
	}

}
