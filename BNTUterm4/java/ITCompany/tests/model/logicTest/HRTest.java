package model.logicTest;

import static org.junit.Assert.*;

import org.junit.BeforeClass;
import org.junit.Test;
import model.entity.HR;
import model.entity.Boss;
import model.entity.DevHR;
import model.entity.Employee;
import model.entity.groups.ITCompany;
import model.entity.groups.ProjectTeam;
import model.factory.BossFactory;
import model.factory.DevHRFactory;
import model.logic.MyArray;
import model.logic.Storable;

public class HRTest {

	private static ITCompany epam;
	private static ProjectTeam pt;
	
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		epam = new ITCompany("Epam", "MyList");
		pt = new ProjectTeam("Default");
		DevHR dhr = (DevHR) new DevHRFactory().create(1).get(0);
		Boss boss = (Boss) new BossFactory().create(1).get(0);
		dhr.setPlaceOfWork(epam);
		dhr.setProject(pt);
		Storable<Employee> st = new MyArray();
		st.add(dhr);
		st.add(boss);
		dhr.setIdToEmployee(st);
		dhr.setPlaceOfWorkToEmployee(st);
		dhr.setProjectToEmployee(st, pt);
		pt.setMember(st);
		epam.getTeams().add(pt);
		((Boss) epam.getTeams().get(0).getMember().get(1)).showMembers();
	}

	@Test
	public final void testSearchApplyers1() {
		int expected = 3, actual;
		((HR) epam.getTeams().get(0).getMember().get(0)).searchApplyers(expected);
		actual = epam.getAspirants().size();
		assertEquals(expected, actual);
	}
}
