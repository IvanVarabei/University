package patterns.creational.factoryMethod;

public abstract class Furniture {
	abstract void print();
}
class Chair extends Furniture{
	void print() {System.out.println("I'm a chair");}	
}

class Table extends Furniture{
	void print() {System.out.println("I'm a table");}	
}

abstract class FurnitureFactory {
	abstract Furniture createFurniture();
}

class ChairFactory extends FurnitureFactory{
	Furniture createFurniture() {
		return new Chair();
	}
}

class TableFactory extends FurnitureFactory{
	Furniture createFurniture() {
		return new Table();
	}
}