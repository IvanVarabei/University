package patterns.behavioral.mediator;

public class Gate {

	private String gateName;
	private boolean inUse;
	
	public Gate(String name, boolean inU) {
		gateName = name;
		inUse = inU;
	}

	public String getGateNum() {
		return gateName;
	}

	public void setInUse(boolean inUse) {
		this.inUse = inUse;
	}

	public boolean isInUse() {
		return inUse;
	}
}
