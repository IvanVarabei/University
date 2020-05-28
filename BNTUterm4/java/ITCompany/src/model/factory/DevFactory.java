package model.factory;

import static model.logic.Utils.rand;

import model.entity.Developer;
import model.entity.Employee;
import model.logic.MyList;
import model.logic.Storable;

public class DevFactory implements EmployeeFactory {

	private final static int MIN_SKILL = 10;
	private final static int MAX_SKILL = 100;

	public DevFactory() {
		// TODO Auto-generated constructor stub
	}

	public Storable<Employee> create(int n) {
		Storable<Employee> ms = new MyList();
		for (int i = 0; i < n; i++) {
			ms.add(new Developer(names[rand(0, names.length - 1)], rand(MIN_AGE, MAX_AGE), false, DEFAULT_ID, null,
					null, "Develop", rand(MIN_COST, MAX_COST), rand(MIN_SKILL, MAX_SKILL)));
		}
		return ms;
	}

}
