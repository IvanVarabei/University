package model.entity;

import static model.logic.Utils.*;
import static view.Output.*;
import model.entity.groups.ITCompany;
import model.entity.groups.ProjectTeam;
import model.logic.Storable;

public class PM extends Employee {

	public PM(String name, int age, boolean isHasJob, int id, ITCompany placeOfWork, ProjectTeam project,
			String calling, int cost) {
		super(name, age, isHasJob, id, placeOfWork, project, calling, cost);
	}

	public PM(PM pm) {
		super(pm);
	}

	public boolean isCommonId(int id, Employee... ms) {
		boolean res = false;
		for (int i = 0; i < ms.length; i++) {
			if (ms[i].getId() == id) {
				res = true;
				break;
			}
		}
		return res;
	}

	public int searchProjectTeamByName(String name) {
		return model.logic.Utils.searchProjectTeamByName(placeOfWork, name);
	}

	public Employee searchById(int elem) {
		Employee res = null;
		for (int i = 0; i < placeOfWork.getTeams().size(); i++) {
			if (search(placeOfWork.getTeams().get(i).getMember(), elem) != null) {
				res = search(placeOfWork.getTeams().get(i).getMember(), elem);
				break;
			}
		}
		return res;
	}

	public int searchTeamIndexById(int id) {
		int res = 0;
		for (int i = 0; i < placeOfWork.getTeams().size(); i++) {
			if (search(placeOfWork.getTeams().get(i).getMember(), id) != null) {
				res = i;
				break;
			}
		}
		return res;
	}

	public int searchEmpIndexById(Storable<Employee> storable, int id) {
		int res = 0;
		for (int i = 0; i < storable.size(); i++) {
			if (((Employee) storable.get(i)).getId() == id) {
				res = i;
			}
		}
		return res;
	}

	public void moveEmployeeToOtherTeam(String newTeam, int id) {
		int TargetTeam = searchProjectTeamByName(newTeam);
		int currentTeam = searchTeamIndexById(id);
		int empNumber = searchEmpIndexById(placeOfWork.getTeams().get(currentTeam).getMember(), id);
		placeOfWork.getTeams().get(TargetTeam).getMember().add(searchById(id));
		placeOfWork.getTeams().get(currentTeam).getMember().remove(empNumber);
		searchById(id).setProject(placeOfWork.getTeams().get(TargetTeam));
	}

	public void sort(String teamName, String key) {
		switch (key.toLowerCase()) {
		case "cost":
			sortCost(placeOfWork.getTeams().get(searchProjectTeamByName(teamName)).getMember());
			break;
		case "age":
			sortAge(placeOfWork.getTeams().get(searchProjectTeamByName(teamName)).getMember());
			break;
		case "name":
			sortName(placeOfWork.getTeams().get(searchProjectTeamByName(teamName)).getMember());
			break;
		}
	}

	@Override
	public void work() {
		exhibit(getName() + " is managing!");
	}

}


