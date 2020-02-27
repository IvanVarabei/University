package model;

import static model.Utils.*;

import model.Workable;
import model.Developer;
import model.Human;
import model.MyFactory;
import static view.Output.*;

//extends emloyee
public abstract class HR extends Employee {
	public final static int THRESHOLD = 40;

	public HR() {

	}

	public HR(String name, int age, boolean isHasJob, int id, String placeOfWork, String calling, int cost) {
		super(name, age, isHasJob, id, placeOfWork, calling, cost);
	}

	public HR(HR hr) {
		super(hr);
	}
	
	public abstract void accept(Developer dev) ;
	

	@Override
	public void work() {
		exhibitRed("Human Resource is working!");
	}

	// accept Employee
	// getClass is it dev
	// биржа труда вакантные дожности
	// то что меньше платит меньше
	// рандом
	

	public Developer[] searchApplyers(int PreferableNmberOfCandidats, Developer[] applyers, MyFactory factory) {

		Developer[] res = combainArrays(applyers, factory.developerCrete(PreferableNmberOfCandidats, false));
		return res;
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
