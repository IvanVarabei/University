package patterns.behavioral.mediator;

import java.util.Timer;
import java.util.TimerTask;

public class Flight {

	private AtcMediator atc;
	private String flightNum;
	private Runway runway;
	private Gate gate;
	
	public Flight(AtcMediator atc, String flightNum) {
		this.atc = atc;
		this.flightNum = flightNum;
	}

	public Runway getRunway() {
		return runway;
	}
	
	public String getNum() {
		return flightNum;
	}

	public void allocateRunway(Runway runway) {
		this.runway = runway;
	}

	public void allocateGate(Gate gate) {
		this.gate = gate;
	}

	
	public void landAndTakeOff() throws InterruptedException{
		System.out.println(flightNum + " is requesting landing permission ");
		while(atc.getLandPermission(this)==false) {
			Thread.sleep(1000);
		}
		land();
		//System.out.println(flightNum + " is requesting take-off permission ");
		while(atc.getTakeoffPermission(this)==false) {
			Thread.sleep(1000);
		}
		takeOff();
	}
	
	public void land() {
		atc.enterRunway(runway);
		System.out.println(flightNum + " is landing, gate is " + gate.getGateNum());
		new Timer().schedule(new TimerTask() {
			@Override
			public void run() {
				atc.exitRunway(runway);
				atc.enterGate(gate);
			}
		},1000);
	}
	
	public void takeOff() {
		new Timer().schedule(new TimerTask() {
			@Override
			public void run() {
				System.out.println(flightNum + " is taking off ");
				atc.exitGate(gate);
				atc.enterRunway(runway);
				new Timer().schedule(new TimerTask() {
					@Override
					public void run() {
						atc.exitRunway(runway);
					}
				},1000);
			}
		},5000);
	}

}
