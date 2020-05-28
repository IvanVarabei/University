package model.entity.groups;

import java.util.*;

import model.*;
import model.entity.Employee;
import model.entity.Workable;
import model.logic.MyArray;
import model.logic.MyList;
import model.logic.Storable;

public class ProjectTeam extends Group{
	//technology
	private Storable<Employee> member = new MyList();
	private int timeToDevProject;
	private int budget;
	
	public ProjectTeam(String name) {
		super(name);
	}

	public ProjectTeam(String name, int budget, int timeToDevProject, Storable<Employee> members) {
		super(name);
		this.budget = budget;
		this.timeToDevProject = timeToDevProject;
		member = members;
	}

	public ProjectTeam(String name, int budget, int timeToDevProject) {
		super(name);
		this.budget = budget;
		this.timeToDevProject = timeToDevProject;
	}

	public Storable<Employee> getMember() {
		return member;
	}

	public void setMember(Storable<Employee> member) {
		this.member = member;
	}

	public int getTimeToDevProject() {
		return timeToDevProject;
	}

	public void setTimeToDevProject(int timeToDevProject) {
		this.timeToDevProject = timeToDevProject;
	}

	public int getBudget() {
		return budget;
	}

	public void setBudget(int budget) {
		this.budget = budget;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + Objects.hash(budget, member, timeToDevProject);
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
		ProjectTeam other = (ProjectTeam) obj;
		return budget == other.budget && Objects.equals(member, other.member)
				&& timeToDevProject == other.timeToDevProject;
	}

	@Override
	public String toString() {
		return getName();
	}

}
