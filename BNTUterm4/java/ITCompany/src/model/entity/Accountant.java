package model.entity;

import model.entity.groups.ITCompany;
import model.entity.groups.ProjectTeam;
import static model.logic.Utils.searchProjectTeamByName;
import static view.Output.exhibit;



public class Accountant extends Employee {

	public Accountant(String name, int age, boolean isHasJob, int id, ITCompany placeOfWork, ProjectTeam project,
			String calling, int cost) {
		super(name, age, isHasJob, id, placeOfWork, project, calling, cost);
	}

	public Accountant(Accountant pm) {
		super(pm);
	}

	public Employee searchCheapest() {
		Employee cheapest = placeOfWork.getTeams().get(0).getMember().get(0);
		for(Object projTeam : placeOfWork.getTeams()) {
			for(Object employee : ((ProjectTeam)projTeam).getMember()) {
				if(((Employee)employee).getCost() < cheapest.getCost())
					cheapest = (Employee)employee;
			}
		}
		return cheapest;
	}
	
	public Employee searchDearest() {
		Employee cheapest = placeOfWork.getTeams().get(0).getMember().get(0);
		for(Object projTeam : placeOfWork.getTeams()) {
			for(Object employee : ((ProjectTeam)projTeam).getMember()) {
				if(((Employee)employee).getCost() > cheapest.getCost())
					cheapest = (Employee)employee;
			}
		}
		return cheapest;
	}
	
	public int countExps() {
		int sum = 0;
		for (int i = 0; i < placeOfWork.getTeams().size(); i++) {
			sum += countExps(placeOfWork.getTeams().get(i).getName());
		}
		return sum;
	}

	public int countProfit() {
		int sum = 0;
		for (int i = 0; i < placeOfWork.getTeams().size(); i++) {
			sum += countProfit(placeOfWork.getTeams().get(i).getName());
		}
		return sum;
	}

	public int countExps(String name) {
		int index = searchProjectTeamByName(placeOfWork, name); 
		int sum = 0;
		for (int i = 0; i < placeOfWork.getTeams().get(index).getMember().size(); i++) {
			sum += placeOfWork.getTeams().get(index).getMember().get(i).getCost();
		}
		return sum * placeOfWork.getTeams().get(index).getTimeToDevProject();
	}

	public int countProfit(String name) {
		int index = searchProjectTeamByName(placeOfWork, name); 
		return placeOfWork.getTeams().get(index).getBudget() 
				- countExps(placeOfWork.getTeams().get(index).getName());
	}

	public int countAllBudgets() {
		int result = 0;
		for (int i = 0; i < placeOfWork.getTeams().size(); i++) {
			result += placeOfWork.getTeams().get(i).getBudget();
		}
		return result;
	}
	
	@Override
	public void work() {
		exhibit(getName() + " is accounting!");
	}

}
