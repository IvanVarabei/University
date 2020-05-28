package view;

import static view.Output.exhibit;

import model.entity.Employee;
import model.entity.groups.ITCompany;
import model.entity.groups.ProjectTeam;

public class Output {
	public static void exhibit(String str) {
		System.out.println(str);
	}
	
	public static void exhibitThatLine(String str) {
		System.out.print(str);
	}
	
	public static void exhibit(Employee str) {
		System.out.println(str.toString());
	}
	
	public static void exhibit(ProjectTeam str) {
		System.out.println("\nTeam name=" + str.toString() + 
				"\n" +"Budget=" + str.getBudget()+ " $\n"
				+"Term=" + str.getTimeToDevProject() + " months");		
		for(Object e : str.getMember()) {
			System.out.println(((Employee)e).toString());
		}
		exhibit("");
	}
	
	public static void exhibit(ITCompany str) {
		exhibit("\nCompany name : " + str.toString());
		for(int i = 0; i< str.getTeams().size(); i++) {
			exhibit(str.getTeams().get(i));
		}
		exhibit("");
	}

	public static void exhibitRed(String str) {
		System.err.println(str);
	}

}
