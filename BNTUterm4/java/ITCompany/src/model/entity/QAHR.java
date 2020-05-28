package model.entity;

import static view.Output.*;

import model.entity.groups.ITCompany;
import model.entity.groups.ProjectTeam;
import model.factory.QAFactory;
import model.logic.MyArray;
import model.logic.Storable;

public class QAHR extends HR {


	public QAHR(String name, int age, boolean isHasJob, int id, ITCompany placeOfWork, ProjectTeam project,
			String calling, int cost) {
		super(name, age, isHasJob, id, placeOfWork, project, calling, cost);
	}

	public void searchApplyers(int PreferableNmberOfCandidats) {
		placeOfWork.getAspirants().addAll(new QAFactory().create(PreferableNmberOfCandidats));
	}

	public void interview(int n, String project) {
		Storable<Employee> accepted = new MyArray();
		int counter = 0;
		for (int i = 0; i < placeOfWork.getAspirants().size(); i++) {
			if ((placeOfWork.getAspirants().get(i).getClass() == QA.class
					&& ((QA) placeOfWork.getAspirants().get(i)).getCost() <= 1300)) {
				placeOfWork.getAspirants().get(i).setIsHasJob(true);
				accepted.add(placeOfWork.getAspirants().get(i));
				placeOfWork.getAspirants().remove(i--);
				if (++counter == n) {
					break;
				}
			}
		}
		if (counter < n) {
			exhibit("Very few QA aspirants !");
		}
		setProjectToEmployee(accepted,placeOfWork.getTeams().get(searchProjectTeamByName(project)));
		setIdToEmployee(accepted);
		setPlaceOfWorkToEmployee(accepted);
		placeOfWork.getTeams().get(searchProjectTeamByName(project)).getMember().addAll(accepted);
	}

	@Override
	public void work() {
		exhibit(getName() + " is searching QAs!");
	}

	@Override
	public int hashCode() {
		return super.hashCode();
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
		return true;
	}

	@Override
	public String toString() {
		return super.toString();
	}

}
