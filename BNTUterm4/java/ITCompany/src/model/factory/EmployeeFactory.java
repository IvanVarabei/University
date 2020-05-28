package model.factory;

import model.entity.Employee;
import model.logic.Storable;

public interface EmployeeFactory {
	 String[] names = { "Valera", "Ivan", "Oleg", "Max", "Sasha", "Piter", "Boris", "Ignat" };
	 int MIN_AGE = 18;
	 int MAX_AGE = 50;
	 int MIN_COST = 1000;
	 int MAX_COST = 2000;
	 int DEFAULT_ID = 0;

	public Storable<Employee> create(int n);
}
