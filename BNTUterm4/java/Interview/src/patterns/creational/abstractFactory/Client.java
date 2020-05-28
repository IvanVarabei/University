package patterns.creational.abstractFactory;

public class Client {
//creates families of objects
	public static void main(String ...fdg) {
		DoorFactory df = new WoodenDoorFactory();
		Door d = df.createDoor();
		Fitter f = df.makeFittingExpert();
		d.getDiscription();
		f.getDiscription();
	}
}

interface Door{
	void getDiscription();
}

interface Fitter{
	void getDiscription();
}

class Carpenter implements Fitter{
	public void getDiscription() {System.out.println("I am a carpenter");}
}

class Welder implements Fitter{
	public void getDiscription() {System.out.println("I am a welder");}
}

class WoodDoor implements Door{
	public void getDiscription() {System.out.println("I am a Wooden door");}
}

class MetalDoor implements Door{
	public void getDiscription() {System.out.println("I am a metal door");}
}

interface DoorFactory{
	Door createDoor() ;
	Fitter makeFittingExpert();
}

class WoodenDoorFactory implements DoorFactory{
	public Door createDoor() {
		return new WoodDoor();
	}
	public Fitter makeFittingExpert() {
		return new Carpenter();
	}	
}

class MetalDoorFactory implements DoorFactory{
	public Door createDoor() {
		return new MetalDoor();
	}
	public Fitter makeFittingExpert() {
		return new Welder();
	}
}