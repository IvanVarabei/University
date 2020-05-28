package model.entity;

import model.entity.groups.ITCompany;
import model.entity.groups.ProjectTeam;
import model.factory.AccountantFactory;
import model.factory.DevHRFactory;
import model.factory.PMFactory;
import model.factory.QAHRFactory;
import model.logic.Storable;
import model.logic.Utils;
import static model.logic.Utils.*;
import static view.Output.*;

import java.util.*;

public abstract class HR extends Employee {

	public final static int THRESHOLD = 40;

	public HR(HR hr) {
		super(hr);
	}

	public HR(String name, int age, boolean isHasJob, int id, ITCompany placeOfWork, ProjectTeam project,
			String calling, int cost) {
		super(name, age, isHasJob, id, placeOfWork, project, calling, cost);
	}

	public abstract void searchApplyers(int PreferableNmberOfCandidats);

	public abstract void interview(int n, String project);

	public void createProjTeam(String name, int budget, int term, int nPM, int nDevHR, int nQAHR, int nAcc) {
		ProjectTeam newTeam = new ProjectTeam(name, budget, term);
		newTeam.getMember().addAll(new PMFactory().create(nPM));
		newTeam.getMember().addAll(new DevHRFactory().create(nDevHR));
		newTeam.getMember().addAll(new QAHRFactory().create(nQAHR));
		newTeam.getMember().addAll(new AccountantFactory().create(nAcc));
		placeOfWork.getTeams().add(newTeam);
		setProjectToEmployee(placeOfWork.getTeams().get(placeOfWork.getTeams().size() - 1).getMember(), newTeam);
		setIdToEmployee(placeOfWork.getTeams().get(placeOfWork.getTeams().size() - 1).getMember());
		setPlaceOfWorkToEmployee(placeOfWork.getTeams().get(placeOfWork.getTeams().size() - 1).getMember());

	}

	public void setIdToEmployee(Storable<? extends Employee> storable) {
		for (int i = 0; i < storable.size(); i++) {
			if (storable.get(i).getId() == 0) {
				int newId = placeOfWork.getSpareIds()[rand(0, placeOfWork.getSpareIds().length - 1)];
				storable.get(i).setId(newId);
				placeOfWork.setReservedIds(addElem(placeOfWork.getReservedIds(), newId));
				placeOfWork.setSpareIds(
						Utils.delElem(placeOfWork.getSpareIds(), searchIndexByValue(placeOfWork.getSpareIds(), newId)));
			}
		}
	}

	public void setPlaceOfWorkToEmployee(Storable<Employee> storable) {
		for (int i = 0; i < storable.size(); i++) {
			storable.get(i).setPlaceOfWork(placeOfWork);
		}
	}

	public void setProjectToEmployee(Storable<Employee> storable, ProjectTeam project) {
		for (int i = 0; i < storable.size(); i++) {
			storable.get(i).setProject(project);
		}
	}

	public void showAspirants() {
		exhibit("This is the aspirants: ----------------");
		for (int i = 0; i < placeOfWork.getAspirants().size(); i++) {
			exhibit(placeOfWork.getAspirants().get(i).toString());
		}
	}

	public int searchProjectTeamByName(String name) {
		return model.logic.Utils.searchProjectTeamByName(placeOfWork, name);
	}

	@Override
	public void work() {
		exhibitRed("Human Resource is working!");
	}

}
