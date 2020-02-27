package model;

import java.util.Objects;

import model.Human;

public abstract class Employee extends Human {

	private int id;

	public void setId(int id) {//only read
		this.id = id;
	}

	public int getId() {
		return id;
	}

	public Employee() {
		// TODO Auto-generated constructor stub
	}

	public Employee(String name, int age, boolean isHasJob, int id) {
		super(name, age, isHasJob);
		/*this.setAge(age);
		this.setIsHasJob(isHasJob);*/
		this.id = id;
	}
	
	

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + Objects.hash(id);
		return result;
	}
//интерфейс когда мы зотим объеденить разные иерархии
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
		//super.equals(obj);
		Employee other = (Employee) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return super.toString();// 
	}1
	
	

}
