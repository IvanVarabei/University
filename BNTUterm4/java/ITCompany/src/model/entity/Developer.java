package model.entity;

import model.entity.Developer;
import model.entity.groups.ITCompany;
import model.entity.groups.ProjectTeam;

import static view.Output.*;

import java.util.Objects;

public class Developer extends Employee {
	private int skill;// mark from 1 to 100, for example 51

	public Developer(Developer dev) {
		super(dev);
		skill = dev.skill;
	}

	public Developer(String name, int age, boolean isHasJob, int id, ITCompany placeOfWork,ProjectTeam project, String calling, int cost,
			int skill) {
		super(name, age, isHasJob, id, placeOfWork,project, calling, cost);
		this.skill = skill;
	}

	public void setSkill(int skill) {
		this.skill = skill;
	}

	public int getSkill() {
		return skill;
	}

	@Override
	public void work() {
		exhibit(this.getName() + "\t is writing code!");
	}

	

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + Objects.hash(skill);
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
		return skill == other.skill;
	}

	@Override
	public String toString() {
		return super.toString() + "\tskill=" + skill;
	}

}
