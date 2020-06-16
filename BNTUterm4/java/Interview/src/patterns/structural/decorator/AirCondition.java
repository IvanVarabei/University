package patterns.structural.decorator;

public class AirCondition extends Decorator{

	Car car;
	
	public AirCondition(Car car) {
		this.car = car;
	}

	@Override
	public String getInfo() {
		return car.getInfo() + "+AirCondition";
	}

	@Override
	public int getPrice() {
		return car.getPrice() + 3000 ;
	}

}
