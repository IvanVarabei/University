package enumTest;

abstract class Furniture {}
class Table extends Furniture {}
class Chair extends Furniture {}

public enum FurnitureFactory {
	TableFactory {
		Table create() {return new Table();		}
	},
	ChairFactory {
		Chair create() {return new Chair();	}
	};
	abstract Furniture create();
	public static Furniture getFurniture(FurnitureFactory type) {
		return type.create();
	}
}
