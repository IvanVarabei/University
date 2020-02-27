package model;

import model.Developer;
import model.Employee;
import model.IWorkAble;
import static view.Output.*;

import java.util.Objects;

public class Developer extends Employee implements IWorkAble{//without I , able lowerCase
	private int skill;
	
	public void setSkill(int skill) {
		this.skill= skill;
	}
	
	public int getSkill() {
		return skill;
	}
	
	public Developer() {
		
	}
	
	public Developer(String name, int age, boolean isHasJob, int skill, int id) {
		//super(vvv);
		this.setName(name);
		this.setAge(age);
		this.setIsHasJob(isHasJob); 
		this.setId(id);
		this.skill= skill;
	}
	
	public Developer(Developer dev) {
		//super.
		this.setName(dev.getName());
		this.setAge(dev.getAge());
		this.setIsHasJob(dev.getIsHasJob());
		this.setId(dev.getId());
		//ostav
		skill= dev.skill;
	}
	
	

	public void work() {
		exhibit(this.getName()+"\t is writing code!");
	}
	
	
	
	@Override
	public int hashCode() {
		return this.toString().hashCode();
	}
	

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		Developer other = (Developer) obj;
		return skill == other.skill;
	}

	@Override
	public String toString() {
		return "Developer [skill=" + skill + ", toString()=" + super.toString() + "]";
	}

	
}
