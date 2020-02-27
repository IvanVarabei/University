package model;

import static model.Utils.*;
import static view.Output.*;
import model.Developer;
import model.Human;
import model.IWorkAble;

public class PM extends Human implements IWorkAble{

	public PM() {

	}
	
	public void work() {
		exhibitRed("Project manager is working!");
	}
//ref to company
	//field with companyname
	//no need to //
	public Developer searchById(Developer[] ms, int elem) {
		return binarySearch(ms, elem);
	}

	public void showDevs(Developer[] ms) {
		for (int i = 0; i < ms.length; i++) {
			exhibit(ms[i].toString());
		}
	}

	public Developer[] sortList(Developer[] ms, String key) {
		//ms dev[]
		//no plural return
		switch (key) {
		case "age":
			return sortAge(ms);
		case "skill":
			return sortSkill(ms);
		case "name":
			return sortName(ms);
		default:
			return null;
		}
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
		return "PM [toString()=" + super.toString() + "]";
	}
	
	
}
