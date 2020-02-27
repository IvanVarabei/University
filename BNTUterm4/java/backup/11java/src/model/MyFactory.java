package model;

import static model.Utils.*;
import model.CSharpDev;
import model.Developer;
import model.HR;
import model.JavaDev;
import static view.Output.*;

public class MyFactory implements IWorkAble{
	private final static String[] names = { "Valera", "Ivan", "Oleg", "Max", "Sasha", "Piter", "Boris", "Ignat" };
	private final static int MIN_AGE = 18;
	private final static int MAX_AGE = 50;
	private final static int MIN_SKILL = 10;
	private final static int MAX_SKILL = 100;
	private final static int MIN_ID = 1000;
	private final static int MAX_ID = 9999;

	public int[] spareIds;
	public int[] reservedIds;

	public MyFactory() {
		spareIds = new int[MAX_ID - MIN_ID];
		reservedIds = new int[MAX_ID - MIN_ID];
		for (int i = 0, j = MIN_ID; j < MAX_ID; i++, j++) {
			spareIds[i] = j;
		}
	}
	
	public void work() {
		exhibitRed("Factory is working!");
	}

	public Developer developerCrete(int n, boolean flag)[] {
		Developer ms[] = new Developer[n];
		int minSkill;
		if (flag) {
			minSkill = HR.THRESHOLD;
		} else {
			minSkill = MIN_SKILL;
		}

		for (int i = 0; i < n; i++) {
			int newId = spareIds[rand(0, spareIds.length - 1)];
			if (rand(1, 2) == 1) {
				ms[i] = new JavaDev(names[rand(0, names.length - 1)], rand(MIN_AGE, MAX_AGE), flag,
						rand(minSkill, MAX_SKILL), newId);

			} else {
				ms[i] = new CSharpDev(names[rand(0, names.length - 1)], rand(MIN_AGE, MAX_AGE), flag,
						rand(minSkill, MAX_SKILL), newId);
			}
			reservedIds = addElem(reservedIds, newId);
			spareIds = delElem(spareIds, searchIndexByValue(spareIds, newId));
		}
		return ms;
	}

}
