package modelTests;

import static org.junit.Assert.*;

import org.junit.Test;

import model.Boss;
import model.Park;
import model.Vehicle;

public class ParkTest {

	@Test
	public final void testSearchMaxCost() {
		Vehicle[] ms = new Vehicle[4];
		ms[0] = new Vehicle("Mers", 300);//before after
		ms[1] = new Vehicle("Bumer", 700);
		ms[2] = new Vehicle("Reno", 200);
		ms[3] = new Vehicle("Lada", 400);
		Park park = new Park(ms);
		Boss boss = new Boss();
		Vehicle res = boss.searchMaxCost(park);
		//expected actial
		//assert
		if(!res.equals(ms[1])) {
			fail("Not yet implemented"); // TODO
		}
		
	}
	
	@Test
	public final void testCountCost() {
		Vehicle[] ms = new Vehicle[4];
		ms[0] = new Vehicle("Mers", 300);
		ms[1] = new Vehicle("Bumer", 700);
		ms[2] = new Vehicle("Reno", 200);
		ms[3] = new Vehicle("Lada", 400);
		Park park = new Park(ms);
		Boss boss = new Boss();
		int res = boss.countCost(park);
		if(res != 1600) {
			fail("Not yet implemented"); // TODO
		}
		
	}

}
