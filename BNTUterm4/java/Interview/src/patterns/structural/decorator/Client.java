package patterns.structural.decorator;

public class Client {

	public static void main(String ...df) {
		Car car1 = new AudiA3();
		System.out.println(car1.getInfo());
		System.out.println(car1.getPrice());
		
		car1= new GPS(car1);
		System.out.println(car1.getInfo());
		System.out.println(car1.getPrice());
		
		car1= new AirCondition(car1);
		System.out.println(car1.getInfo());
		System.out.println(car1.getPrice());
		
		Car car2 = new AirCondition(new GPS(new AudiA4()));
		System.out.println(car2.getInfo());
		System.out.println(car2.getPrice());
	}
}
