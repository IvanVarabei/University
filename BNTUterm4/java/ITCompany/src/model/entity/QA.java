package model.entity;

import static view.Output.exhibit;
import model.entity.groups.ITCompany;
import model.entity.groups.ProjectTeam;

public class QA extends Employee {


	public QA(QA qa) {
		super(qa);
	}

	public QA(String name, int age, boolean isHasJob, int id,ITCompany  placeOfWork,ProjectTeam project, String calling, int cost) {
		super(name, age, isHasJob, id, placeOfWork,project, calling, cost);
	}

	@Override
	public void work() {
		exhibit(this.getName() + " is testing product!");
	}
}
