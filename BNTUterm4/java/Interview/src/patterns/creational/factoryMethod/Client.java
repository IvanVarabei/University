package patterns.creational.factoryMethod;

public class Client {
	public static void main(String ...d) {
		FurnitureFactory fact = new ChairFactory();
	Chair c = new Chair();
		meth(fact);
	}

	static void meth(FurnitureFactory f) {
			Furniture furn = f.createFurniture();
			furn.print();
		}

}
