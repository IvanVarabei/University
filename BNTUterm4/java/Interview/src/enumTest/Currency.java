package enumTest;


enum Highlander {
	JAVA;
	Highlander() {
		if (ordinal() != 0) {
			throw new IllegalStateException("В живых должен остаться только один");
		}
		init();
	}
	private void init() {
		// код здесь!
	}
	/** java-doc */
	public String getOwner(String index) {
		// логика здесь
		return "Джеймс Гослинг, Sun Microsystems";
	}
}



enum MessageUtil {

	; // required to avoid compiler error, also signifies no instance

	public static boolean isValid() {
		throw new UnsupportedOperationException("Not supported yet.");
	}
}


public enum Currency implements Runnable {
	
	PENNY(1) {
		void compalsory() {		}
	}, 
	NICKLE(5) {
		void compalsory() {		}
	}, 
	DIME(10) {
		{
			System.out.println("DIME din");
		}
		void compalsory() {		}
	},
	QUARTER(25){
		public int general (int j) {return j*100;}
		public void print() {System.out.println("print");		}
		void compalsory() {		}
	};
	
	static {
		System.out.println("static block");
	}
	{
		System.out.println("instance block");
	}
	int value;
	Currency(int i) {
		System.out.println("Constr");
		value = i;}
	int general(int b) {return b * b;}
	abstract void compalsory();

	@Override
	public String toString() {
		String str = "";
		switch (this) {
		case PENNY:
			str += "PENNY = " + this.value;
			break;
		case NICKLE:
			str += "NICKLE = " + this.value;
			break;
		case DIME:
			str += "DIME = " + this.value;
			break;
		case QUARTER:
			str += "QUARTER = " + this.value;
			break;
		}
		return str;
	}

	@Override
	public void run() {	}
}
