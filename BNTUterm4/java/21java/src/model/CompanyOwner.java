package model;

import static model.Utils.*;
import model.Developer;
import model.PM;
import static view.Output.*;

import javafx.concurrent.Worker;

public class CompanyOwner extends PM {

	public CompanyOwner() {

	}
	
	public void compelToWork(Workable ... ms) {
		for(int i =0 ;i<ms.length; i++) {
			ms[i].work();
		}
		exhibit("\n");
	}

	public Developer[] fireWeakMember(Developer[] ms) {
		return delElem(ms, searchMinSkill(ms));
	}

	
	
	@Override
	public void showDevs(Developer[] ms) {
		for (int i = 0; i < ms.length; i++) {
			if (searchMinSkill(ms) == i) {
				exhibitRed(ms[i].toString());
			} else {
				exhibit(ms[i].toString());
			}
		}
	}

	//вернуть массив слабейших
	private static int searchMinSkill(Developer[] ms) {
		int res = 0;
		for (int i = 0; i < ms.length; i++) {
			if (ms[i].getSkill() < ms[res].getSkill()) {
				res = i;
			}
		}
		return res;
	}
}
