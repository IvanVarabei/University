package by.bntu.fitr.varabei.javalabs.lab09.model;

import static org.junit.Assert.*;

import org.junit.Test;

public class PrimeTest {

	@Test
	public void IsPrimeTest1() {
		assertEquals(true,Prime.isPrime(3));
	}
	
	@Test
	public void IsPrimeTest2() {
		assertEquals(true,Prime.isPrime(19));
	}
	
	@Test
	public void IsPrimeTest3() {
		assertEquals(false,Prime.isPrime(34));
	}
	
	@Test
	public void IsPrimeTest4() {
		assertEquals(false,Prime.isPrime(100));
	}
	
	@Test
	public void GetPrimeByNumberTest1() {
		assertEquals(2,Prime.getPrimeByNumber(1));
	}
	
	@Test
	public void GetPrimeByNumberTest2() {
		assertEquals(29,Prime.getPrimeByNumber(10));
	}
	
	@Test
	public void GetPrimeByNumberTest3() {
		assertEquals(79,Prime.getPrimeByNumber(22));
	}

}
