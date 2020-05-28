package patterns.structural.decorator;

class GPS extends Decorator{

	Car car;
	
	public GPS(Car car) {
		this.car = car;
	}

	@Override
	public String getInfo() {
		return car.getInfo() + "+GPS";
	}

	@Override
	public int getPrice() {
		return car.getPrice() + 1500 ;
	}

}
