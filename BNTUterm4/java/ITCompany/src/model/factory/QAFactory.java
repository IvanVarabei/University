package model.factory;

import static model.logic.Utils.rand;

import model.entity.Employee;
import model.entity.QA;
import model.entity.QAHR;
import model.logic.MyList;
import model.logic.Storable;

public class QAFactory implements EmployeeFactory {

	public QAFactory() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public Storable<Employee> create(int n) {
		Storable<Employee> ms = new MyList();
		for (int i = 0; i < n; i++) {
			ms.add(new QA(names[rand(0, names.length - 1)], rand(MIN_AGE, MAX_AGE), false, DEFAULT_ID, null, null,
					"QA", rand(MIN_COST, MAX_COST)));
		}
		return ms;
	}

}
