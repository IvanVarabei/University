package model;

import model.Developer;
import static view.Output.*;

public class JavaDev extends Developer {

	public JavaDev() {

	}

	public JavaDev(String name, int age, boolean isHasJob, int skill, int id) {
		this.setName(name);
		this.setAge(age);
		this.setIsHasJob(isHasJob);
		this.setSkill(skill);
		this.setId(id);
	}

	public JavaDev(Developer dev) {
		this.setName(dev.getName());
		this.setAge(dev.getAge());
		this.setIsHasJob(dev.getIsHasJob());
		this.setSkill(dev.getSkill());
		this.setId(dev.getId());
	}

	@Override
	public void work() {
		exhibit(this.getName() + "\t is writing JAVA code!");
	}

}
