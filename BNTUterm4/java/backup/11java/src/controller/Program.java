package controller;

import static model.Utils.*;
import model.ITCompany;
import static view.Output.*;

public class Program {
	private static final String MENU = "\n1 - Compel developers to work\n"
			+ "2 - Add new developers from candidats through interview\n"
			+ "3 - Serch new candidats around the Linkedin\n4 - View developers list\n"
			+ "5 - View candidats list\n6 - Sort developers list\n"
			+ "7 - Boss fires the weakest developer\n"
			+ "8 - Boss is monitoring employee's skills\n"
			+ "9 - PM searches the developer by ID\n"
			+ "Enter desirable action : ";

	public static void main(String[] args) {
		exhibitRed("Creating a company");
		int n = readInt("Enter default number of developers : "),
				m = readInt("Enter default number of candidates : ");
		ITCompany epam = new ITCompany(n, m);
		while (true) {
			switch (readInt(MENU)) {
			case 1:
				epam.work();
				break;
			case 2:
				epam.addDev();
				break;
			case 3:
				epam.addApplyers(readInt("Enter number of applyers : "));
				break;
			case 4:
				epam.viewDevsList();
				break;
			case 5:
				epam.viewApplyersList();
				break;
			case 6:
				epam.sortDevs(readStr("Enter key:'name', 'age', 'skill': "));
				break;
			case 7:
				epam.fire();
				break;
			case 8:
				epam.CompOwnerViewDevsList();
				break;
			case 9:
				epam.searchById(readInt("Enter desirable id : "));
				break;
			default:
				return;
			}
		}
	}

}