package controller;

import static model.logic.Utils.*;
import static view.Output.*;


import model.entity.*;
import model.entity.groups.ITCompany;
import model.entity.groups.ProjectTeam;
import model.factory.BossFactory;
import model.factory.DevHRFactory;
import model.logic.MyArray;
import model.logic.Storable;
import model.logic.Utils;



public class Program {

	public static void main(String... args) {
	
		ITCompany epam = new ITCompany("Epam", "MyList");
		ProjectTeam pt = new ProjectTeam("Default");
		DevHR dhr = (DevHR) new DevHRFactory().create(1).get(0);
		Boss boss = (Boss) new BossFactory().create(1).get(0);
		dhr.setPlaceOfWork(epam);
		dhr.setProject(pt);
		Storable<Employee> st = new MyArray();
		st.add(dhr);
		st.add(boss);
		dhr.setIdToEmployee(st);
		dhr.setPlaceOfWorkToEmployee(st);
		dhr.setProjectToEmployee(st, pt);
		pt.setMember(st);
		epam.getTeams().add(pt);
		((Boss) epam.getTeams().get(0).getMember().get(1)).showMembers();
		
		l0: while (true) {
			Employee currentEmployee = Utils.searchById(epam, readInt("Enter ID to apply to particilar employee:"));
			if (currentEmployee == null)
				return;
			if (currentEmployee.getClass() == Boss.class) {
				while (true) {
					switch (readInt("\n1-Show all IT company\n2-Compel all employees to work\n"
							+ "3-fire employee by ID\n4-dissolve project team by name\n")) {
					case 1:
						((Boss) currentEmployee).showMembers();
						break;
					case 2:
						((Boss) currentEmployee).compelToWork();
						break;
					case 3:
						((Boss) currentEmployee).fireMember(readInt("Enter ID:"));
						break;
					case 4:
						((Boss) currentEmployee).dissolveTeam(readStr("Team name:"));
						break;
					default:
						continue l0;
					}
				}
			}
			if (currentEmployee.getClass() == PM.class) {
				while (true) {
					switch (readInt("\n1-search employee by ID\n2-move an employee to other team\n"
							+ "3-sort employees in particilar team\n")) {
					case 1:
						exhibit(((PM) currentEmployee).searchById(readInt("Enter ID:")));
						break;
					case 2:
						((PM) currentEmployee).moveEmployeeToOtherTeam(readStr("Team name:"), readInt("Enter ID:"));
						break;
					case 3:
						((PM) currentEmployee).sort(readStr("Team name:"), readStr("Enter sort key:"));
						;
						break;
					default:
						continue l0;
					}
				}
			}
			if (currentEmployee.getClass() == DevHR.class) {
				while (true) {
					switch (readInt("\n1-create a new team\n2-show aspirants\n3-search team by name\n"
							+ "4-search new candidats\n5-interview existing candidats\n")) {
					case 1:
						((DevHR) currentEmployee).createProjTeam(readStr("Team name:"), 1000, 1, 1, 1, 1, 1);
						break;
					case 2:
						((DevHR) currentEmployee).showAspirants();
						break;
					case 3:
						exhibit(((DevHR) currentEmployee).getPlaceOfWork().getTeams()
								.get(((DevHR) currentEmployee).searchProjectTeamByName(readStr("Team name:"))));
						break;
					case 4:
						((DevHR) currentEmployee).searchApplyers(readInt("Enter preferable n of Developer candidats:"));
						break;
					case 5:
						((DevHR) currentEmployee).interview(readInt("Enter preferable n of Developer to hire:"),
								readStr("Team name:"));
						break;
					default:
						continue l0;
					}
				}
			}
			if (currentEmployee.getClass() == QAHR.class) {
				while (true) {
					switch (readInt("\n1-create a new team\n2-show aspirants\n3-search team by name\n" + "4-search "
							+ "new candidats\n5-interview existing candidats\n")) {
					case 1:
						((QAHR) currentEmployee).createProjTeam(readStr("Team name:"), 1000, 1, 1, 1, 1, 1);
						break;
					case 2:
						((QAHR) currentEmployee).showAspirants();
						break;
					case 3:
						exhibit(((QAHR) currentEmployee).getPlaceOfWork().getTeams()
								.get(((QAHR) currentEmployee).searchProjectTeamByName(readStr("Team name:"))));
						break;
					case 4:
						((QAHR) currentEmployee).searchApplyers(readInt("Enter preferable n of Developer candidats:"));
						break;
					case 5:
						((QAHR) currentEmployee).interview(readInt("Enter preferable n of Developer to hire:"),
								readStr("Team name:"));
						break;
					default:
						continue l0;
					}
				}
			}
			if (currentEmployee.getClass() == Accountant.class) {
				while (true) {
					switch (readInt("\n1-count IT company budget\n2-count IT Company expenses\n"
							+ "3-count team expens\n4-count team profit\n5-count IT Company Profit\n"
							+ "6-search the cheapest employee\n7-search the dearest employee\n")) {
					case 1:
						exhibit("IT company budget:" + ((Accountant) currentEmployee).countAllBudgets());
						break;
					case 2:
						exhibit("IT Company expenses:" + ((Accountant) currentEmployee).countExps());
						break;
					case 3:
						exhibit("Team expenses:" + ((Accountant) currentEmployee).countExps(readStr("Team name:")));
						break;
					case 4:
						exhibit("Team profit:" + ((Accountant) currentEmployee).countProfit(readStr("Team name:")));
						break;
					case 5:
						exhibit("IT Company profit:" + ((Accountant) currentEmployee).countProfit());
						break;
					case 6:
						exhibit("The cheapest employee:" + ((Accountant) currentEmployee).searchCheapest());
						break;
					case 7:
						exhibit("The dearest employee:" + ((Accountant) currentEmployee).searchDearest());
						break;
					default:
						continue l0;
					}
				}
			}
		}

	}

}