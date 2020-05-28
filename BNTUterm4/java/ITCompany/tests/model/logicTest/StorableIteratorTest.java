package model.logicTest;

import static org.junit.Assert.*;

import java.util.Iterator;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Ignore;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.Timeout;

import model.logic.MyArray;
import model.logic.Storable;
import model.logic.StorableIterator;

public class StorableIteratorTest {

	private static final int AMOUNT = 3;
	private static Storable<Integer> data = new MyArray();
	
	@Rule
	public final Timeout timeout = new Timeout(1);
	
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		for(int i =0; i< AMOUNT; i++) {
			data.add(i);
		}
	}


	@Test(timeout =4, expected = NullPointerException.class)
	public final void testHasNext1() {
		Iterator<Integer> iter = data.iterator();
		assertTrue(iter.hasNext());
		throw new NullPointerException();
	}
	
	@Test(timeout = 1)
	public final void testHasNext2() {
		Iterator<Integer> iter = data.iterator();
		for(int i =0 ; i < AMOUNT; i++) {
			iter.hasNext();
			iter.next();
		}
		assertFalse(iter.hasNext());
	}

	@Test
	public final void testNext() {
		int expected = 0;
		int actual = data.iterator().next();
		assertEquals(expected, actual);
	}

}
