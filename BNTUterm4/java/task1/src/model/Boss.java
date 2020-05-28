package model;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/*
java 5.0 boxing , unboxing, generic, collection. java.util.*, forEach
Arrays = Array + sevice
Collections = collection + sevice
*/
public class Boss {

	public Boss() {
		// TODO Auto-generated constructor stub
	}
	
	//field park
	
	 public int countCost(Park park) {//do static
		 List<String> l = new ArrayList();
		 Iterator it = l.iterator();
		 
		 if(park == null) {
			 return -1;
		 }
		int sum = 0;
		for (int i = 0; i < park.getMs().length; i++) {
			sum += park.getMs()[i].getCost();
		}
		return sum;
	}
	 
	 public Vehicle searchMaxCost(Park park) {
		 if(park == null) {
			 return null;
		 }
			Vehicle max = park.getMs()[0];
			for (int i = 0; i < park.getMs().length; i++) {
				if (park.getMs()[i].getCost() > max.getCost()) {
					max = park.getMs()[i];
				}
			}
			return max;
		}

}
