package oop.interaction;

import java.util.*;

class Room {
	private List<Wall> walls = new ArrayList<>();
	private List<Furniture> furniture = new ArrayList<>();

	public Room(int wallNum, List<Furniture> furniture) {
		for (int i = 0; i < wallNum; i++) {
			walls.add(new Wall());
		}
		this.furniture = furniture;
	}
}

class Wall {

}

class Furniture {

}



class Card {
	private int id;

	public Card(int id) {
		this.id = id;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
}

class Employee {
	private Card card;

	public Card getCard() {
		return card;
	}

	public void setCard(Card card) {
		this.card = card;
	}

}



public class Association {

	private static int ID = 21;
	private static int WALLS_NUMBER = 21;

	public static void main(String... ms) {

		Employee employee = new Employee();
		employee.setCard(new Card(ID));

		List<Furniture> furniture = new ArrayList<>();
		furniture.add(new Furniture());
		furniture.add(new Furniture());

		Room room = new Room(WALLS_NUMBER, furniture);

	}
}
