package model.entity;

import java.util.Objects;

import model.entity.groups.ITCompany;
import model.entity.groups.ProjectTeam;

import static view.Output.*;

public class Employee extends Human implements Workable {

	private int id;
	protected ITCompany placeOfWork;// Name of the company, for example: epam
	private ProjectTeam project;
	private String calling;// Profession(charge)
	private int cost;// purchase per month, for example: $1200
	

	public Employee(String name, int age, boolean isHasJob, int id, ITCompany placeOfWork, ProjectTeam project,
			String calling, int cost) {
		super(name, age, isHasJob);
		this.id = id;
		this.placeOfWork = placeOfWork;
		this.project = project;
		this.calling = calling;
		this.cost = cost;
	}

	public Employee(Employee employee) {
		super(employee);
		id = employee.id;
		placeOfWork = employee.placeOfWork;
		project = employee.project;
		calling = employee.calling;
		cost = employee.cost;
	}

	public void work() {
		exhibitThatLine(getName() + " ... ");
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public ITCompany getPlaceOfWork() {
		return placeOfWork;
	}

	public void setPlaceOfWork(ITCompany placeOfWork) {
		this.placeOfWork = placeOfWork;
	}

	public ProjectTeam getProject() {
		return project;
	}

	public void setProject(ProjectTeam project) {
		this.project = project;
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

	

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + Objects.hash(calling, cost, id, placeOfWork, project);
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
				&& Objects.equals(placeOfWork, other.placeOfWork) && Objects.equals(project, other.project);
	}

	@Override
	public String toString() {
		return super.toString() + "\tID=" + id + "\tplaceOfWork=" + placeOfWork + "\tproject=" + project+ "\tcalling="
				+ calling + "\tcost=" + cost;
	}

}
