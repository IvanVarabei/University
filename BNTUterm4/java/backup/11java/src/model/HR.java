package model;

import static model.Utils.*;

import model.IWorkAble;
import model.Developer;
import model.Human;
import model.MyFactory;
import static view.Output.*;

//extends emloyee
public class HR extends Human implements IWorkAble{
	public final static int THRESHOLD = 40;

	public void work() {
		exhibitRed("Human Resource is working!");
	}
	
	//accept Employee
	//getClass is it dev
	//биржа труда вакантные дожности 
	//то что меньше платит меньше
	//рандом 
	public void accept(Developer dev) {
		if (dev.getSkill() > THRESHOLD) {
			dev.setIsHasJob(true);
		}
	}

	public Developer[] searchApplyers(int PreferableNmberOfCandidats, Developer[] applyers, MyFactory factory) {

		Developer[] res = combainArrays(applyers, factory.developerCrete(PreferableNmberOfCandidats, false));
		return res;
	}

}
