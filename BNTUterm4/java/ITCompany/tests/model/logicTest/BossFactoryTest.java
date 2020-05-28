package model.logicTest;

import static org.junit.Assert.*;

import org.junit.Test;
import model.entity.Boss;
import model.entity.Employee;
import model.factory.BossFactory;
import model.logic.MyArray;

public class BossFactoryTest {

	@Test
	public final void testBossFactory() {
		assertEquals(new BossFactory().getClass(), BossFactory.class);
	}

	@Test
	public final void testCreate() {
		MyArray data = new MyArray();
		data.addAll(new BossFactory().create(4));
		for(int i =0; i< data.size(); i++) {
			try{
				Employee t = (Boss)(data.get(i));
			}
			catch(Exception e){
				fail();
			}
		}
	}

}
