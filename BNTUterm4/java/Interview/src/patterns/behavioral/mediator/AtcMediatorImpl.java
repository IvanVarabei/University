package patterns.behavioral.mediator;

import java.util.*;

public class AtcMediatorImpl implements AtcMediator{

	private Runway runway;
	private List<Gate> gates;
	
	public AtcMediatorImpl() {
		gates = new ArrayList();
	}

	@Override
	public void registerRunway(Runway runway) {
		this.runway = runway;
	}

	@Override
	public void registerGate(Gate gate) {
		gates.add(gate);
	}

	@Override
	public boolean getLandPermission(Flight flight) {
		if(runway.isInUse() == false) {
			for(Gate gate : gates) {
				if(gate.isInUse() == false) {
					flight.allocateRunway(runway);
					flight.allocateGate(gate);
					return true;
				}
			}
			System.out.println("[ATC Mediator] all gates in use TO " + flight.getNum());
		}
		else 
			System.out.println("[ATC Mediator] runway in use TO " + flight.getNum());
		return false;
	}

	@Override
	public boolean getTakeoffPermission(Flight flight) {
		return runway.isInUse() == false;
	}

	@Override
	public void enterRunway(Runway runway) {
		runway.setInUse(true);
	}

	@Override
	public void exitRunway(Runway runway) {
		runway.setInUse(false);
	}

	@Override
	public void enterGate(Gate gate) {
		gate.setInUse(true);
	}

	@Override
	public void exitGate(Gate gate) {
		gate.setInUse(false);
	}

}
