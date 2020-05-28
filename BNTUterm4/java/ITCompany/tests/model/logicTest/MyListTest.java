package model.logicTest;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import model.logic.MyList;
import model.logic.Storable;

public class MyListTest {

	private final static int NUMBER_OF_ELEMS = 3;
	private Storable<Integer> expected;

	
	@Before
	public void init(){
		expected = new MyList();
		for(int i = 0; i< NUMBER_OF_ELEMS ; i++)
			expected.add(i);
	}
	

	@Test
	public final void testAddAll() {
		Storable<Integer> buf = new  MyList();
		buf.add(1);
		buf.add(2);		
		
		Storable<Integer> actual = new  MyList();
		actual.add(0);
		actual.addAll(buf);
		assertEquals(actual, expected);
	}
	
	@Test
	public final void testRemoveFirst() {
		Storable<Integer> actual = new  MyList();
		actual.add(12);
		actual.add(0);
		actual.add(1);
		actual.add(2);
		actual.remove(0);
		assertEquals(actual, expected);
	}
	
	@Test
	public final void testRemoveMidl() {
		Storable<Integer> actual = new  MyList();
		actual.add(0);
		actual.add(1);
		actual.add(55);
		actual.add(2);
		actual.remove(2);
		assertEquals(actual, expected);
	}

	@Test
	public final void testRemoveLast() {
		Storable<Integer> actual = new  MyList();
		actual.add(0);
		actual.add(1);
		actual.add(2);
		actual.add(12);
		actual.remove(3);
		assertEquals(actual, expected);
	}

	@Test
	public final void testGet() {
		int expected = 1;
		int actual = this.expected.get(1);
		assertEquals(expected, actual);
	}

	@Test
	public final void testSize() {
		int expected = 3;
		int actual = this.expected.size();
		assertEquals(expected , actual);
	}

	@Test
	public final void testSet() {
		Storable<Integer> actual = new  MyList();
		actual.add(0);
		actual.add(11);
		actual.add(2);
		actual.set(1, 1);
		assertEquals(actual, this.expected);
	}

}
