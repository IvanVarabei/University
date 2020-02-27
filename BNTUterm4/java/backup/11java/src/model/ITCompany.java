package model;

import static model.Utils.*;
import model.CompanyOwner;
import model.Developer;
import model.HR;
import model.MyFactory;
import model.PM;
import static view.Output.*;

public class ITCompany {
	//static del
	//emp[]
	//getClass
	private static Developer devs[];
	private static Developer applyers[];
	private static HR localHR;
	private static PM localPM;
	private static CompanyOwner localCompOwner;
	private static MyFactory factory;
	
	//не нужно имплементить интерфейсы в дочерних классах
	//команды
	//проекты
	//бюджет
	//затраты на команды
	//сколько проекты принесли денег

	public ITCompany(int devNum, int applyersNum) {
		localCompOwner = new CompanyOwner();
		localHR = new HR();
		localPM = new PM();
		factory = new MyFactory();
		devs = factory.developerCrete(devNum, true);
		applyers = factory.developerCrete(applyersNum, false);
	}

	// COMPANY OWNER CAHRGE STRTS
	public void work() {
		localCompOwner.compelToWork(devs);
		localCompOwner.compelToWork(localHR);
		localCompOwner.compelToWork(localPM);
		localCompOwner.compelToWork(factory);

	}

	public void fire() {
		devs = localCompOwner.fireWeakMember(devs);
	}

	public void CompOwnerViewDevsList() {
		localCompOwner.showDevs(devs);
	}
	// COMPANY OWNER CAHRGE ENDS

	// PROJECT MANAGER CAHRGE STRTS
	public void viewDevsList() {
		localPM.showDevs(devs);
	}

	public void viewApplyersList() {
		localPM.showDevs(applyers);
	}

	public void sortDevs(String key) {
		devs = localPM.sortList(devs, key);
	}

	public void searchById(int item) {
		exhibitRed(localPM.searchById(devs, item).toString());
	}
	// PROJECT MANAGER CAHRGE ENDS

	// HUMAN RESOURCE CAHRGE STRTS
	public void addApplyers(int preferableNumber) {
		applyers = localHR.searchApplyers(preferableNumber, applyers, factory);
	}

	public void addDev() {
		for (int i = 0; i < applyers.length; i++) {
			localHR.accept(applyers[i]);
			if (applyers[i].getIsHasJob() == true) {
				devs = addElem(devs, applyers[i]);
				applyers = delElem(applyers, i--);
			}
		}
	}
	// HUMAN RESOURCE CAHRGE ENDS

}
