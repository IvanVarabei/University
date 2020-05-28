package model.entity.groups;

import model.entity.*;
import model.logic.*;
import java.util.*;

public class ITCompany extends Group {
	private final int MIN_ID = 1000;
	private final int MAX_ID = 9999;

	private Storable<ProjectTeam> teams;
	private Storable<Employee> aspirants;
	private int[] spareIds;
	private int[] reservedIds;


	{
		spareIds = new int[MAX_ID - MIN_ID];
		reservedIds = new int[MAX_ID - MIN_ID];
		for (int i = 0, j = MIN_ID; j < MAX_ID; i++, j++) {
			spareIds[i] = j;
		}
	}

	public ITCompany(String name, String type) {
		super(name);
		this.name = name;
		teams = (type.equalsIgnoreCase("myarray")) ? new MyArray() : new MyList();
		aspirants = (type.equalsIgnoreCase("myarray")) ? new MyArray() : new MyList();
	}

	

	public Storable<ProjectTeam> getTeams() {
		return teams;
	}



	public void setTeams(Storable<ProjectTeam> teams) {
		this.teams = teams;
	}



	public Storable<Employee> getAspirants() {
		return aspirants;
	}



	public void setAspirants(Storable<Employee> aspirants) {
		this.aspirants = aspirants;
	}



	public int[] getSpareIds() {
		return spareIds;
	}



	public void setSpareIds(int[] spareIds) {
		this.spareIds = spareIds;
	}



	public int[] getReservedIds() {
		return reservedIds;
	}



	public void setReservedIds(int[] reservedIds) {
		this.reservedIds = reservedIds;
	}



	@Override
	public int hashCode() {
		final int prime = 31;
		int result = super.hashCode();
		result = prime * result + Arrays.hashCode(reservedIds);
		result = prime * result + Arrays.hashCode(spareIds);
		result = prime * result + Objects.hash(aspirants, teams);
		return result;
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
		ITCompany other = (ITCompany) obj;
		return Objects.equals(aspirants, other.aspirants) && Arrays.equals(reservedIds, other.reservedIds)
				&& Arrays.equals(spareIds, other.spareIds) && Objects.equals(teams, other.teams);
	}

	@Override
	public String toString() {
		return getName();
	}
}

// найти самую не/эффектиную команду
// найти самого не/эффектвного сотрудника
// К полям класса применимы модификаторы public, protected, private, static,
// final, transient, volatile.
