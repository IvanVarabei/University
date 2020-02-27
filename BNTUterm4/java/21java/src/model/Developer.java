package model;

import model.Developer;
import model.Employee;
import model.Workable;
import static view.Output.*;

import java.util.Objects;

public class Developer extends Employee {
	private int hardSkill;// mark from 1 to 100, for example 51
	private int softSkill;

	public Developer() {

	}

	public Developer(String name, int age, boolean isHasJob, int id, String placeOfWork,
			String calling, int cost,int hardSkill, int softSkill) {
		super(name, age, isHasJob, id, placeOfWork, calling, cost);
		this.hardSkill = hardSkill;
		this.softSkill = softSkill;
	}

	public Developer(Developer dev) {
		super(dev);
		hardSkill = dev.hardSkill;
		softSkill = dev.softSkill;
	}

	public void setHardSkill(int hardSkill) {
		this.hardSkill = hardSkill;
	}

	public int getHardSkill() {
		return hardSkill;
	}

	public void setSoftSkill(int softSkill) {
		this.softSkill = softSkill;
	}

	public int getSoftSkill() {
		return softSkill;
	}

	@Override
	public void work() {
		exhibit(this.getName() + "\t is writing code!");
	}
	

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + Objects.hash(hardSkill, softSkill);
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
		Developer other = (Developer) obj;
		return hardSkill == other.hardSkill && softSkill == other.softSkill;
	}

	@Override
	public String toString() {
		return super.toString() + "hardSkill=" + hardSkill + "softSkill="+ softSkill;
	}

}
