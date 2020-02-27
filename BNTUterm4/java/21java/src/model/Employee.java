package model;

import java.util.Objects;

import model.Human;

public class Employee extends Human implements Workable {

	private int id;
	private String placeOfWork;// Name of the company, for example: epam
	private String calling;
	private int cost;// purchase per month, for example: $1200

	public Employee() {

	}

	public Employee(String name, int age, boolean isHasJob, int id, String placeOfWork, String calling, int cost) {
		super(name, age, isHasJob);
		this.id = id;
		this.placeOfWork = placeOfWork;
		this.calling = calling;
		this.cost = cost;
	}

	public Employee(Employee employee) {
		super(employee);
		id = employee.id;
		placeOfWork = employee.placeOfWork;
		calling = employee.calling;
		cost = employee.cost;
	}

	public int getId() {// only read
		return id;
	}

	public String getPlaceOfWork() {
		return placeOfWork;
	}

	public void setPlaceOfWork(String placeOfWork) {
		this.placeOfWork = placeOfWork;
	}

	public String getCalling() {
		return calling;
	}

	public void setCalling(String calling) {
		this.calling = calling;
	}

	public int getCost() {
		return cost;
	}

	public void setCost(int cost) {
		this.cost = cost;
	}

	public void work() {

	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + Objects.hash(calling, cost, id, placeOfWork);
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (!super.equals(obj)) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		Employee other = (Employee) obj;
		return Objects.equals(calling, other.calling) && cost == other.cost && id == other.id
				&& Objects.equals(placeOfWork, other.placeOfWork);
	}

	@Override
	public String toString() {
		return super.toString() + "ID=" + id + "placeOfWork" + placeOfWork + "calling=" + calling + "cost=" + cost;
	}

}
