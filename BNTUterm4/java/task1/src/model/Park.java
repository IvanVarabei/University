package model;

import java.util.Arrays;

public class Park {

	private Vehicle[] ms;

	public Park() {
//create empy
	}

	public Park(Vehicle[] ms) {
		this.ms = ms;
	}

	public Park(int n) {
		ms = new Vehicle[n];
		for (int i = 0; i < n; i++) {
			ms[i] = new Vehicle();
		}
	}

	

	public Vehicle[] getMs() {
		return ms;
	}

	public void setMs(Vehicle[] ms) {
		this.ms = ms;
	}

	@Override
	public String toString() {
		String str = "";
		for (int i = 0; i < ms.length; i++) {//for each
			str += ms[i].toString();
		}
		return str;
	}

}
