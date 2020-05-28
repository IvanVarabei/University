package model;

import java.util.Objects;

public class Vehicle {

	private String name;
	private int cost;

	public Vehicle() {
		cost = rand(100,200);
		//initialize here
	}

	public Vehicle(String name, int cost) {
		this.name = name;
		this.cost = cost;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCost() {
		return cost;
	}

	public void setCost(int cost) {
		this.cost = cost;
	}
	
	private static int rand(int from, int to) {
		return from + (int) (Math.random() * (to + 1 - from));
	}//Random
	
	

	@Override
	public int hashCode() {
		return Objects.hash(cost, name);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		Vehicle other = (Vehicle) obj;
		return cost == other.cost && Objects.equals(name, other.name);
	}

	@Override
	public String toString() {
		return "Vehicle [name=" + name + ", cost=" + cost + "]\n";
	}

}
