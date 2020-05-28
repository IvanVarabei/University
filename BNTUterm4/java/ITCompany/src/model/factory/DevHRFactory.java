package model.factory;

import static model.logic.Utils.rand;

import model.entity.DevHR;
import model.entity.Employee;
import model.logic.MyList;
import model.logic.Storable;

public class DevHRFactory implements EmployeeFactory{

	public DevHRFactory() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public Storable<Employee> create(int n) {
		Storable<Employee> ms = new MyList();
		for (int i = 0; i < n; i++) {
			ms.add(new DevHR(names[rand(0, names.length - 1)], rand(MIN_AGE, MAX_AGE), true, DEFAULT_ID, null,null,
					"DevelHR", rand(MIN_COST, MAX_COST)));
		}
		return ms;
	}
	
	

}
