package model.entity;

import model.entity.groups.ITCompany;
import model.entity.groups.ProjectTeam;

import static view.Output.*;


public class Boss extends PM {

	public Boss(Boss boss) {
		super(boss);
		return;
	}

	public Boss(String name, int age, boolean isHasJob, int id, ITCompany placeOfWork, ProjectTeam project,
			String calling, int cost) {
		super(name, age, isHasJob, id, placeOfWork, project, calling, cost);
		return;
	}
	
	public void showMembers() {
		exhibit(placeOfWork);
	}
	
	public void compelToWork() {		
		for(Object i : placeOfWork.getTeams()) {
			for(Object j : ((ProjectTeam)i).getMember())
			((Employee)j).work();
		}
		exhibit("\n");	
	}

	public void fireMember(int id) {
		if (isCommonId(id, this)) {
			exhibit("You can't fire yourself!");
		} else {
			int teamNumber = searchTeamIndexById(id);
			int empNumber = searchEmpIndexById(placeOfWork.getTeams().get(teamNumber).getMember(), id);
			placeOfWork.getTeams().get(teamNumber).getMember().remove(empNumber);
		}
	}

	public void dissolveTeam(String name) {
		int ProjectTeamNum = searchProjectTeamByName(name);
		for (int i = 0; i < placeOfWork.getTeams().get(ProjectTeamNum).getMember().size(); i++) {
			if (isCommonId(placeOfWork.getTeams().get(ProjectTeamNum).getMember().get(i).getId(), this)) {
				exhibit("You can't dissolve team that contains yourself!");
				return;
			}
		}
		placeOfWork.getTeams().remove(ProjectTeamNum);
	}
	
	@Override
	public void work() {
		exhibit(getName() + " is governing!");
	}
}
