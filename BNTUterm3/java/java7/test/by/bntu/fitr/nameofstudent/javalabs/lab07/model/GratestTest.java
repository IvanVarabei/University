package by.bntu.fitr.nameofstudent.javalabs.lab07.model;

import static org.junit.Assert.*;

import org.junit.Test;

import by.bntu.fitr.varabei.javalabs.lab07.model.Greatest;

public class GratestTest {

	@Test
	public void testSeekMax() {
		assertEquals(5,Greatest.seekMax(2,3,4,5));
		assertEquals(2,Greatest.seekMax(2,2,2,2));
		assertEquals(0,Greatest.seekMax(-2,-3,0,-4,-5));
		
	}
	@Test
	public void testSeekMin() {
		assertEquals(2,Greatest.seekMin(2,3,4,5));
		assertEquals(-3,Greatest.seekMin(2,-3,4,5));
	}
	
	@Test
	public void testisEquals() {
		assertEquals(false,Greatest.isEquals(2,3,4,5));
		assertEquals(true,Greatest.isEquals(2,2,2,2));
		assertEquals(false,Greatest.isEquals(2,2,2,3));
		assertEquals(false,Greatest.isEquals(29,2,2,2,2,2));
	}

}
