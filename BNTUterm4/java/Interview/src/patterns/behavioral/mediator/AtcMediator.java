package patterns.behavioral.mediator;

public interface AtcMediator {

	void registerRunway(Runway runway);
	void registerGate(Gate gate);
	boolean getLandPermission(Flight flight);
	boolean getTakeoffPermission(Flight flight);
	void enterRunway(Runway runway);
	void exitRunway(Runway runway);
	void enterGate(Gate gate);
	void exitGate(Gate gate);
}
