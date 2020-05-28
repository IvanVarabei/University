package model.entity;

import static view.Output.exhibit;
import model.entity.groups.ITCompany;
import model.entity.groups.ProjectTeam;
import model.factory.DevFactory;
import model.logic.MyArray;
import model.logic.Storable;


public class DevHR extends HR {

	public DevHR(DevHR hr) {
		super(hr);
	}

	public DevHR(String name, int age, boolean isHasJob, int id, ITCompany placeOfWork, ProjectTeam project,
			String calling, int cost) {
		super(name, age, isHasJob, id, placeOfWork, project, calling, cost);
	}

	public void searchApplyers(int PreferableNmberOfCandidats) {
		placeOfWork.getAspirants().addAll(new DevFactory().create(PreferableNmberOfCandidats));
	}

	public void  interview(int n, String project) {
		Storable<Employee> accepted = new MyArray();
		int counter = 0;
		for (int i = 0; i < placeOfWork.getAspirants().size(); i++) {
			if ((placeOfWork.getAspirants().get(i).getClass() == Developer.class)
					&& ((Developer) placeOfWork.getAspirants().get(i)).getSkill() >= THRESHOLD) {
				placeOfWork.getAspirants().get(i).setIsHasJob(true);
				accepted.add(placeOfWork.getAspirants().get(i));
				placeOfWork.getAspirants().remove(i--);
				if (++counter == n) {
					break;
				}
			}
		}
		if (counter < n) {
			exhibit("Very few Developer aspirants !");
		}
		setProjectToEmployee(accepted,placeOfWork.getTeams().get(searchProjectTeamByName(project)));
		setIdToEmployee(accepted);
		setPlaceOfWorkToEmployee(accepted);
		placeOfWork.getTeams().get(searchProjectTeamByName(project)).getMember().addAll(accepted);
	}
	
	

	@Override
	public void work() {
		exhibit(getName() + " is searching people!");
	}

}
