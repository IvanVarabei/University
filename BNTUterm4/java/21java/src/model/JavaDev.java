package model;

import model.Developer;
import static view.Output.*;

public class JavaDev extends Developer {

	public JavaDev() {

	}

	public JavaDev(String name, int age, boolean isHasJob, int id, String placeOfWork, String calling, int cost,
			int hardSkill, int softSkill) {
		super(name, age, isHasJob, id, placeOfWork, calling, cost, hardSkill, softSkill);
	}

	public JavaDev(Developer dev) {
		super(dev);
	}

	@Override
	public void work() {
		exhibit(this.getName() + "\t is writing JAVA code!");
	}

}
