package model.factory;

import static model.logic.Utils.rand;
import model.entity.Accountant;
import model.entity.Employee;
import model.logic.MyList;
import model.logic.Storable;

public class AccountantFactory implements EmployeeFactory{

	public AccountantFactory() {
		// TODO Auto-generated constructor stub
	}
	
	@Override
	public Storable<Employee> create(int n) {
		Storable<Employee> ms = new MyList();
		for (int i = 0; i < n; i++) {
			ms.add(new Accountant(names[rand(0, names.length - 1)], rand(MIN_AGE, MAX_AGE), true, DEFAULT_ID, null,null, "Account",
					rand(MIN_COST, MAX_COST)));
		}
		return ms;
	}

}
