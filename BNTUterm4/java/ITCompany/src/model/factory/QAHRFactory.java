package model.factory;

import static model.logic.Utils.rand;

import model.entity.Employee;
import model.entity.QAHR;
import model.logic.MyList;
import model.logic.Storable;

public class QAHRFactory implements EmployeeFactory{

	public QAHRFactory() {

	}

	@Override
	public Storable<Employee> create(int n) {
		Storable<Employee> ms = new MyList();
		for (int i = 0; i < n; i++) {
			ms.add(new QAHR(names[rand(0, names.length - 1)], rand(MIN_AGE, MAX_AGE), true, DEFAULT_ID, null,null, "QAHR",
					rand(MIN_COST, MAX_COST)));
		}
		return ms;
	}

}
